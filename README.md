# OpenRA on Switch (Atmosphere)

将 OpenRA（红警 1 / 命令与征服 复刻引擎）移植到 Nintendo Switch 大气层（Atmosphere / hbmenu）的原生 homebrew 客户端，含红警 2 风格 NSP 前端直通图标与全面中文化。

## 第三版任务、声音与缩放修复测试包

补齐建筑与遭遇战选项中文；重写任务界面的资源显示与启动衔接，修正暂停菜单后的重复音效抑制，增加 720p 安全缩放选项并限制菜单预览预热。包内 60 个任务的地图、预览与简报完整，但缺少可选视频；详细核查、构建和测试边界见 [第三版说明](docs/repair-v3.md)。仍待 Switch 真机验收，不代表已完成战役通关或 FPS 测试。

## 最新单人开局修复（待真机验收）

**第二版已修复第一版的 FileSystemWatcher 启动回归**，并恢复原包未入库的平台与存档路径兼容处理。第二版仍待真机确认。

针对遭遇战连接失败、战役点击开始无反应，新增 **Switch 单人进程内传输**，保留原游戏服务器与协议，绕过 mono-nx 的本机 Socket 故障。
同时关闭 Mono 详细日志、默认暂停菜单背景战场并使用软件光标。

实际服务器/客户端的遭遇战和战役握手、开局指令测试已在 Linux x64 通过；Switch 真机和帧率改善仍待验收。
构建、测试和证据见 [修复说明](docs/single-player-fix.md)。仅需覆盖 OpenRA.Game.dll 和 mono/config.ini，NRO/NSP 无需重装。

## 运行前提

- Switch 已破解并安装 **Atmosphere + hbmenu**
- 将 `pkg/` 目录内全部内容拷贝到 **SD 卡根目录**：
  - `switch/OpenRA/openra.nro` → homebrew 程序本体
  - `mono/openra/` → mono 运行时 + OpenRA 程序集 + mods + 游戏数据 + 中文翻译
  - `RedAlert2-OpenRA-Forwarder.nsp` → 红警 2 主题 NSP 前端（需安装到系统，图标直达 `\switch\OpenRA\openra.nro`）
- 在 hbmenu 中启动 `OpenRA`，或从桌面直接点红警 2 图标进入

> 首次启动会生成设置文件；如更新版本后画面/缩放异常，删除 `mono/openra/Support/settings.yaml` 后重试。

## 移植架构

| 组件 | 说明 |
|---|---|
| NRO | mono-nx 交叉构建的 .NET 运行时 + OpenRA 启动器（devkitA64） |
| 程序集 | dotnet 以 `TRACE;SWITCH` 编译的 .NET 9 托管程序集（Release） |
| 数据 | 官方 playtest-20260222 资源 + `global mix database.dat` + NotoSansSC 中文字体 |
| 前端 | 自制 NSP forwarder（titleid `010000000000F000`，图标为红警 2 风格徽章） |

## 中文版

- 战役/任务地图标题 74 个已中文化（`translations/map-titles/`）
- 任务目标/剧情提示（lua.ftl）286 条、战役角色（campaign.ftl）、界面（chrome.ftl）已全量翻译
- 中文字体：NotoSansSC Regular/Bold（`mono/openra/mods/common/`）
- 语言机制：按 key 直接替换 Fluent .ftl 值，无需改 C#（FluentBundle 全量覆盖加载）

## 关键源码修改（src/）

| 文件 | 修改 |
|---|---|
| AssemblyLoader.cs | mono 下按程序集名加载（不走 Assembly.LoadFrom） |
| DebugAssertionSuppressor.cs | 屏蔽 mono-nx Debug BCL 的 Debug.Assert 崩溃 |
| Game.cs | GCSettings.LOH 在 Switch 上不支持，try/catch 容错 |
| Sdl2Input.cs | 鼠标速度 ×2；新增触屏控制（单指=左键、双指=右键、长按=按住） |
| Sdl2PlatformWindow.cs | 关闭 SDL 触摸→鼠标合成，防双份输入 |
| Settings.cs | 默认 150% 缩放、720p 渲染、关垂直同步、帧率=游戏刻率、Close 镜头、加大光标 |
| Server/Connection.cs + Network/Connection.cs | libnx socket 不支持切换阻塞模式，try/catch 容错（修复"连接中"闪退） |
| Program.cs（Launcher/Utility/Server） | 启动即抑制 Debug 断言；Launcher 增加未处理异常落盘日志 |
| LogoStripeLoadScreen.cs | 加载台词使用专用 LoadScreen 大字体（28 号，2 倍） |

## 构建

```bash
# 1. 编译程序集（aarch64）
export PATH=<dotnet9路径>:$PATH
dotnet build -c Release '-p:DefineConstants=TRACE;SWITCH'

# 2. 拷贝 dll 到 pkg/mono/openra/
for f in OpenRA.Game.dll OpenRA.Utility.dll OpenRA.dll OpenRA.Platforms.Default.dll \
         OpenRA.Mods.Common.dll OpenRA.Mods.Cnc.dll OpenRA.Mods.D2k.dll OpenRA.Server.dll; do
  cp bin/$f pkg/mono/openra/
done

# 3. 校验 YAML
cp bin/OpenRA.Utility.runtimeconfig.json pkg/mono/openra/
cd pkg/mono/openra && dotnet OpenRA.Utility.dll ra --check-yaml

# 4. NRO（mono-nx，devkitA64 chroot）
sudo chroot dkp-root /bin/bash -c 'cd /root/mono-nx && export DEVKITPRO=/opt/devkitpro \
  && export DEVKITA64=$DEVKITPRO/devkitA64 && export PATH=$DEVKITPRO/devkitA64/bin:$DEVKITPRO/portlibs/switch/bin:$PATH \
  && source env.sh && cd native/interpreter && make -j8 APP_TITLE="OpenRA" APP_AUTHOR="OpenRA on Switch" APP_VERSION="playtest-20260222"'

# 5. 打包
zip -r OpenRA-Switch-Atmosphere.zip pkg/
```

## 安装包

完整安装包（SD 卡直接覆盖）：见 Releases 页 `OpenRA-Switch-Atmosphere.zip`（含 NRO、mono 运行时、mods、翻译、NSP 前端）。

## 实测状态（2026-10-16）

- ✅ 主界面可进入（v12 起）
- ✅ 战役列表 / 任务目标 / 加载台词中文生效（v19/v20）
- ✅ 加载台词字体放大 2 倍（v20）
- ⏳ 遭遇战 / 战役：进程内连接修复通过桌面握手和开局指令测试，待真机验收
- ⏳ 触屏操作（单指左键 / 双指右键 / 长按）待验收

遇到闪退请按 Issues 模板（`.github/ISSUE_TEMPLATE/bug_report.md`）提交日志，重点是 `mono/openra/Support/Logs/` 与 `unhandled.log`。

## 已知限制

- 单人模式已改为进程内传输；真机仍需验证实际地图运行。多人联机未在本次修复范围内验证。若仍有问题请提供 `mono/openra/Support/Logs` 与 `/mono/openra/unhandled.log`
- 部分游戏内单位/建筑名（rules.ftl）与系统通知（common.ftl）仍有少量英文，逐步补齐中
- 仅支持大气层 homebrew 通道；不支持 Switchroot/Linux 方案
