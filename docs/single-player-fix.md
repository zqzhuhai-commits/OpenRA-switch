# 单人开局与性能修复

适用基线：本仓库 v21 / cf46f6a，以及用户提供的 OpenRA-Switch-Atmosphere (4)(1).zip。
上游源码固定为 OpenRA playtest-20260222 / 5c51f458f2e9f8ec4921eea8d07823c8358680f8。

## 第二版：启动回归修复

用户新日志 exception-2026-10-15T180503Z/180526Z 明确显示：
`FileSystemWatcher..ctor -> MapDirectoryTracker..ctor -> MapCache.LoadMaps` 抛 PlatformNotSupportedException。
核对上传原包的 DLL 后发现，它已有未入库的 watcher 容错，以及 Switch 平台和 Support 路径适配。
第一版按仓库覆盖文件重编译时遗漏了这些处理，导致尚未进入主菜单就退出。

第二版新增 MapDirectoryTracker.cs 与 Platform.cs 覆盖文件：

- SWITCH 不创建 FileSystemWatcher，启动时地图枚举和加载仍由 MapCache 正常完成。
- 退出时不访问不存在的 watcher。桌面构建保留文件监视功能。
- 保持原包的 Linux 兼容平台标识、Nintendo Switch 系统名称与引擎目录下的 Support 路径。
- 新增 MapDirectoryTrackerStartup：将文件监视器替换为始终抛 PlatformNotSupportedException 的测试替身，验证启动、更新、重复 Dispose 均可完成。
- 更新完整握手测试，同时检查平台识别、Support 路径及实际地图加载。

以上修复已编译及在桌面回归通过；第二版仍待 Switch 真机确认主菜单和实际游戏画面。

## 故障证据

最新 server.log 中，本地客户端连接 127.0.0.1 后，Server.Connection.SendReceiveLoop
以 SocketException (140): Operation canceled 结束。client.log 随后记录握手读取到 EOF。
战役使用 CreateAndStartLocalServer，遭遇战使用 CreateLocalServer；二者都走同一服务器连接。
现有 SWITCH 分支已跳过 Blocking/NoDelay，说明只绕过这两个属性仍不足以解决该运行时的本机连接问题。

## 修复

SWITCH 构建的 Local/Skirmish 服务器使用 LocalTransport 的两个托管字节队列。
服务器事件线程、服务器 Connection 的帧解析、客户端 NetworkConnection、握手、身份校验、
房间同步、StartGame、游戏指令及回放路径继续使用原有实现；不使用 EchoConnection 代替游戏服务器。
该路径不创建 TCP listener、TcpClient 或 Socket，也不发局域网广播。
多人/专用服务器保留原 TCP 路径。新增的 5 参数构造函数保留原 4 参数构造函数以兼容现有模组 DLL。

性能改动：

- mono/config.ini 关闭 logging 和 runtime_logging，保留普通错误日志输出。
- SWITCH 默认 PauseShellmap=true，暂停菜单背景战场的逻辑运算。
- SWITCH 默认 DisableHardwareCursors=true，直接使用现有软件光标，避免不支持的硬件光标初始化。
- 不调整战局模拟速度、资源、AI、单位上限或 CPU 频率，也未承诺特定帧率。
- 用户 settings.yaml 如显式保存了不同的菜单/光标设置，其显式设置仍优先。

## 构建

需要 .NET 9 SDK 和独立的上游源码 checkout：

```sh
git clone --depth 1 --branch playtest-20260222 https://github.com/OpenRA/OpenRA.git openra-src
scripts/build-managed-hotfix.sh /absolute/path/openra-src /absolute/path/SD-root
```

脚本应用本仓库核心源码覆盖文件并输出 OpenRA.Game.dll。
另将 assets/mono-performance-config.ini 安装为 SD 卡 /mono/config.ini；自定义启动路径的用户应仅修改原配置中的两个 logging 开关。
不需要重新构建 NRO 或重装 NSP。

## 验证范围

- OpenRA.Game Release / net9.0 / SWITCH 编译：0 错误、0 警告。
- LocalTransportRegression：10 次独立连接、真实服务端 Connection 的握手字节、
  分段 170KB 指令、双向收发、关闭/EOF、阻塞读唤醒与超时检查通过。
- SinglePlayerHandshake：加载原安装包的模组和地图，使用真实 Game.CreateLocalServer、
  Server、NetworkConnection，完成握手、服务器开局及客户端收到 StartGame：
  遭遇战“核冬天”和战役“01：激战正酣”通过。
- 上述测试运行于 Linux x64 / .NET 9，不包含 Switch 真机的画面、Lua 战役运行及帧率测量。

底层回归测试：

```sh
dotnet run --project tests/LocalTransportRegression -c Release
```

完整握手测试需要把原安装包的 mono/openra/*.dll 复制到独立 runtime 目录，覆盖新 OpenRA.Game.dll，然后：

```sh
dotnet build tests/SinglePlayerHandshake -c Release -p:RuntimeDir=/absolute/path/runtime
dotnet tests/SinglePlayerHandshake/bin/Release/net9.0/SinglePlayerHandshake.dll /absolute/path/package/mono/openra
```

真机验收：进入遭遇战房间、添加 AI 并开局；启动一关战役；退出后重新开局；测试战役重新开始与存档。
server.log 应出现 `Accepting single-player client using in-process transport (no sockets).`。
若进入地图后仍出错，请保留新异常日志；本次修复不能代替对实际游戏运行的真机验证。
