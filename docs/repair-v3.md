# Switch 第三版修复测试包

这版针对真机反馈的任务点击开始无反应、简报/预览不显示、按钮音效逐渐消失、缩放灰色及菜单负载。它保留第二版的本地传输与启动兼容修复，仍需真机验收。

## 资源核查

对用户上传的原包运行实际 ModData/Fluent/PNG 解码核查：60 个 MissionSelector 任务均有 map.yaml、map.bin、可解码的 map.png 和可解析的简报。不是缺少整套任务地图。81 个不同的可选过场视频引用全部找不到。任务文字原包部分仍是英文，本补丁没有把所有战役文本翻译为中文。

40 个配置曲目仅找到 intro.aud、map.aud 两个隐藏曲目，常规播放列表的音乐文件缺失。详见随包 campaign-content-audit.log。缺失的音乐/视频不能靠界面代码还原，本包未添加这类原版媒体。

## 改动与边界

- 增加独立 OpenRA.SwitchUI.dll，通过 ra/mod.yaml 注册，并仅为 RA 替换任务与显示设置的 Chrome 入口。不替换原 OpenRA.Mods.Common.dll，保留其二进制中未入库的定制内容。
- 任务简报的字体测量与布局改在 UI 线程完成，避免共享字体缓存跨线程访问；取消预热全部任务预览，只由当前地图的预览控件按需请求。
- 视频按钮只在文件实际存在时显示；开始任务直接建立本地会话，不等待可选的开场视频。可另行播放存在的简报视频。启动中禁用重复点击，连接失败恢复按钮并显示失败说明；debug.log 添加选择、启动和就绪阶段记录。
- 本地任务的 setup orders 等待本会话、对应地图和本地玩家信息到齐后发送；创建新本地服务器时关闭旧服务器，避免重试堆积。扩展模块未列在旧启动器 deps.json 时，只在按名加载失败后回退默认程序集上下文，保持 Common 的类型身份。
- 已在真实 OpenAL 的 null 输出后端复现菜单音效缺陷：暂停模拟时 LocalTick 不动，原来的“5 个游戏帧内最多重复 3 次”会永久抑制同类声音。改用 200ms 墙钟窗口，短时节流保留，静止模拟下可恢复播放。
- 用校验原 DLL SHA256 的 Mono.Cecil 补丁只修改原平台 DLL 的 Play2D/Play2DStream 两个方法，保留未入库的 Sdl2GamepadBridge、触屏和渲染代码。src/OpenAlSoundEngine.cs 为对应源码；脚本会拒绝其他原始平台 DLL。
- 720p 菜单提供 75/80/90/100% 缩放；更大选项仍受原最小有效分辨率限制，战斗中仍禁用布局缩放。默认 100%、固定上限 30fps、菜单背景暂停、软件光标和关闭 Mono 详细日志。已有显式设置仍优先，不覆盖 settings.yaml。没有改变模拟速度、CPU 频率或解锁超频。
- 合并建筑、单位、能力名称及遭遇战选项中文补丁，校正原包工程师/谭雅/建造厂等错配。

## 验证

- CampaignContentAudit：实际加载 60 个任务的元数据、简报与 PNG，报告缺失媒体。
- MissionBrowserUI：加载真实任务 YAML 控件及新逻辑，检查简报不为空、选中地图预览可解码、点击开始经自动握手/任务选项/Ready 指令启动真实服务器，重复点击不另建会话；检查 720p 缩放候选及帧率默认值。测试窗口尺寸、字体度量、装饰图标为替代实现，不验证实际 GPU 绘制、Switch 字形、Lua 任务运行或任务完成。
- PausedMenuAudio：真实 OpenAL null 后端，模拟帧保持 0；原 DLL 在等待后仍拒绝按钮音效，补丁 DLL 恢复播放，突发播放节流保留。不能据此保证 Switch 底层音频设备永不失效。
- SinglePlayerHandshake：实际遭遇战与战役地图，本地协议握手、服务器启动并接收 StartGame。
- TranslationValidation：游戏 Fluent 引擎解析及名称、选项、复数时间限制、中文提示解析。
- 平台 DLL 方法差异核查：只有 Play2D/Play2DStream 改变。

未进行 Switch 真机完整战斗、Lua 战役通关或 CPU/FPS 测量，因此第三版为修复测试版，不能宣称所有故障或卡顿已解决。

## 构建

在已有 dotnet9 和原包 DLL 的环境，使用上游 playtest-20260222 的独立检出：

```sh
OPENRA_DOTNET=dotnet scripts/build-switch-ui-hotfix.sh /path/to/upstream /path/to/original/mono/openra /path/to/output/SD-card
```

Mono.Cecil 固定 0.11.6；离线可设置 CECIL_DIR 为同时包含 Mono.Cecil.dll 和 Mono.Cecil.Rocks.dll 的目录。不要把已经修补的原平台 DLL 再用作输入。
