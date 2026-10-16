## Buttons
button-cancel = 取消
button-retry = 重试
button-back = 返回
button-continue = 继续
button-quit = 退出

## Server Orders
notification-custom-rules = 此地图包含自定义规则。游戏体验可能改变。
notification-two-humans-required = 此服务器至少需要两名真人玩家才能开始对局。
notification-unknown-server-command = 未知服务器命令：{ $command }。
notification-admin-start-game = 只有房主才能开始游戏。
notification-no-start-until-required-slots-full = 必需槽位未满，无法开始游戏。
notification-no-start-without-players = 没有玩家时无法开始游戏。
notification-insufficient-enabled-spawn-points = 需要启用更多出生点才能开始游戏。
notification-malformed-command = 格式错误的 { $command } 命令。
notification-state-unchanged-ready = 标记为就绪后无法更改状态。
notification-invalid-faction-selected = 无效的阵营选择：{ $faction }。
notification-state-unchanged-game-started = 游戏开始后无法更改状态（{ $command }）。
notification-requires-host = 只有房主才能执行此操作。
notification-invalid-bot-slot = 无法向已被其他客户端占用的槽位添加机器人。
notification-invalid-bot-type = 无效的机器人类型。
notification-admin-change-map = 只有房主才能更换地图。
notification-player-disconnected = { $player } 已断开连接。
notification-team-player-disconnected = { $player }（队伍 { $team }）已断开连接。
notification-observer-disconnected = { $player }（观战者）已断开连接。
notification-unknown-map = 服务器上未找到地图。
notification-searching-map = 正在资源中心搜索地图...
notification-admin-change-configuration = 只有房主才能更改配置。
notification-changed-map = { $player } 将地图更换为 { $map }。
notification-you-were-kicked = 您已被踢出服务器。
notification-admin-kicked = { $admin } 将 { $player } 踢出了服务器。
notification-kicked = { $player } 已被踢出服务器。
notification-temp-ban = { $admin } 临时封禁了 { $player }。
notification-admin-transfer-admin = 只有管理员才能将管理员权限转移给其他玩家。
notification-admin-move-spectators = 只有房主才能将玩家移至观战。
notification-empty-slot = 该槽位无人。
notification-move-spectators = { $admin } 将 { $player } 移至观战。
notification-nick-changed = { $player } 现在名为 { $name }。
notification-player-dropped = 一名玩家因超时已被移除。
notification-connection-problems = { $player } 遇到连接问题。
notification-timeout-dropped = { $player } 因超时已被移除。
notification-timeout-dropped-in =
    { $timeout ->
        [one] { $player } 将在 { $timeout } 秒后被踢出。
       *[other] { $player } 将在 { $timeout } 秒后被踢出。
    }
notification-error-game-started = 游戏已经开始。
notification-requires-password = 服务器需要密码。
notification-incorrect-password = 密码错误。
notification-incompatible-mod = 服务器正在运行不兼容的模组。
notification-incompatible-version = 服务器正在运行不兼容的版本。
notification-incompatible-protocol = 服务器运行的是不兼容的协议。
notification-you-were-banned = 您已被封禁。
notification-you-were-temp-banned = 您已被临时封禁。
notification-game-full = 游戏已满。
notification-new-admin = { $player } 现在是管理员。
notification-invalid-configuration-command = 无效的配置命令。
notification-admin-option = 只有房主才能设置该选项。
notification-error-number-teams = 无法解析队伍数量：{ $raw }。
notification-admin-kick = 只有房主才能踢出玩家。
notification-kick-self = 房主不能踢出自己。
notification-kick-none = 该槽位无人。
notification-no-kick-game-started = 游戏开始后只能踢出观战者和已战败玩家。
notification-admin-clear-spawn = 只有管理员才能清除出生点。
notification-spawn-occupied = 您不能与其他玩家占用同一出生点。
notification-spawn-locked = 该出生点已锁定给其他玩家槽位。
notification-admin-lobby-info = 只有房主可以设置大厅信息。
notification-invalid-lobby-info = 发送了无效的大厅信息。
notification-player-color-terrain = 颜色已调整，以降低与地形的相似度。
notification-player-color-player = 颜色已调整，以降低与其他玩家的相似度。
notification-invalid-player-color = 无法确定有效的玩家颜色，已选择随机颜色。
notification-invalid-error-code = 解析错误消息失败。
notification-master-server-connected = 主服务器通信已建立。
notification-master-server-error = 主服务器通信失败。
notification-game-offline = 游戏未在线广播。
notification-no-port-forward = 服务器端口无法从互联网访问。
notification-blacklisted-server-name = 服务器名称包含被屏蔽的词语。
notification-requires-authentication = 服务器要求玩家拥有 OpenRA 论坛账号。
notification-no-permission-to-join = 您没有权限加入此服务器。
notification-slot-closed = 您的槽位已被房主关闭。

## ServerOrders, UnitOrders
notification-joined = { $player } 已加入游戏。
notification-lobby-disconnected = { $player } 已离开。

## UnitOrders
notification-game-has-started = 游戏已经开始。
notification-game-paused = { $player } 暂停了游戏。
notification-game-unpaused = { $player } 恢复了游戏。

## Server
notification-game-started = 游戏开始。

## PlayerMessageTracker
notification-chat-temp-disabled =
    { $remaining ->
        [one] 聊天已禁用。请在 { $remaining } 秒后重试。
       *[other] 聊天已禁用。请在 { $remaining } 秒后重试。
    }

## VoteKickTracker
notification-unable-to-start-a-vote = 无法发起投票。
notification-insufficient-votes-to-kick = 票数不足，无法踢出玩家 { $kickee }。
notification-kick-already-voted = 您已经投过票了。
notification-vote-kick-started = 玩家 { $kicker } 发起了踢出玩家 { $kickee } 的投票。
notification-vote-kick-in-progress = { $percentage }% 的玩家已投票踢出玩家 { $kickee }。
notification-vote-kick-ended = 踢出玩家 { $kickee } 的投票失败。

## ActorEditLogic
label-duplicate-actor-id = 重复的单位 ID
label-actor-id = 输入单位 ID
label-actor-owner = 所有者

## ActorSelectorLogic
label-actor-type = 类型：{ $actorType }

## CommonSelectorLogic
options-common-selector =
    .search-results = 搜索结果
    .all = 全部
    .multiple = 多个
    .none = 无

## SaveMapLogic
label-unpacked-map = 解包

dialog-save-map-failed =
    .title = 标题
    .prompt = 提示
    .confirm = 确定

dialog-overwrite-map-failed =
    .title = 标题
    .prompt = 提示
    已存在的地图。
    .confirm = 确定

dialog-overwrite-map-outside-edit =
    .title = 标题
    .prompt = 提示
    保存可能覆盖进度。
    .confirm = 确定

notification-save-current-map = 已保存当前地图。

## GameInfoLogic
menu-game-info =
    .objectives = 任务目标
    .briefing = 任务简报
    .options = 选项
    .debug = 调试
    .chat = 聊天

## GameInfoObjectivesLogic, GameInfoStatsLogic
label-mission-in-progress = 进行中
label-mission-accomplished = 已完成
label-mission-failed = 失败

## GameInfoStatsLogic
label-mute-player = 静音此玩家
label-unmute-player = 取消静音此玩家
button-kick-player = 踢出此玩家
button-vote-kick-player = 投票踢出此玩家

dialog-kick =
    .title = 踢出 { $player }？
    .prompt = 该玩家将无法重新加入游戏。
    .confirm = 踢出

dialog-vote-kick =
    .title = 投票踢出 { $player }？
    .prompt = 该玩家将无法重新加入游戏。
    .prompt-break-bots =
    { $bots ->
        [one] 踢出房主将同时踢出 1 个 AI。
       *[other] 踢出房主将同时踢出 { $bots } 个 AI。
    }
    .vote-start = 发起投票
    .vote-for = 赞成
    .vote-against = 反对
    .vote-cancel = 弃权

notification-vote-kick-disabled = 此服务器已禁用投票踢人。

## GameTimerLogic
label-paused = 已暂停
label-max-speed = 最大速度
label-replay-speed = { $percentage }% 速度
label-replay-complete = 已完成 { $percentage }%

## LobbyLogic, InGameChatLogic
label-chat-disabled = 聊天已禁用
label-chat-availability =
    { $seconds ->
        [one] 聊天将在 { $seconds } 秒后可用…
       *[other] 聊天将在 { $seconds } 秒后可用…
    }

## LobbyLogic, ServerListLogic
label-bot-player = AI 玩家

## LobbyLogic
notification-lobby-option = { $name }：{ $value }。
notification-lobby-option-changed = { $name } 已改为 { $value }。
notification-map-bots-disabled = 此地图已禁用机器人。

## IngameMenuLogic
menu-ingame =
    .leave = 离开
    .abort = 放弃任务
    .restart = 重启
    .surrender = 投降
    .load-game = 载入游戏
    .save-game = 保存游戏
    .music = 音乐
    .settings = 设置
    .return-to-map = 返回地图
    .resume = 继续
    .save-map = 保存地图
    .exit-map = 退出地图编辑器

dialog-leave-mission =
    .title = 标题
    .prompt = 提示
    .confirm = 确定
    .cancel = 保留

dialog-restart-mission =
    .title = 标题
    .prompt = 提示
    .confirm = 确定
    .cancel = 保留

dialog-surrender =
    .title = 标题
    .prompt = 提示
    .confirm = 确定
    .cancel = 保留

dialog-error-max-player =
    .title = 错误：超出最大玩家数
    .prompt = 定义的玩家过多（{ $players }/{ $max }）。
    .confirm = 返回

dialog-exit-map-editor =
    .title = 标题
    .prompt-unsaved = 退出并丢失所有未保存的更改？
    .prompt-deleted = 地图可能已在编辑器外部被删除
    .confirm-anyway = 仍然退出
    .confirm = 确定

dialog-play-map-warning =
    .title = 标题
    .prompt = 提示
    导致无法加载的错误。
    .cancel = 好的

dialog-exit-to-map-editor =
    .title = 标题
    .prompt = 提示
    .confirm = 确定
    .cancel = 保留

## IngamePowerBarLogic
## IngamePowerCounterLogic
label-power-usage = 电力使用：{ $usage }/{ $capacity }
label-infinite-power = 无限电力

## IngameSiloBarLogic
## IngameCashCounterLogic
label-silo-usage = 仓储使用：{ $usage }/{ $capacity }

## ObserverShroudSelectorLogic
options-shroud-selector =
    .all-players = 所有玩家
    .disable-shroud = 禁用迷雾
    .other = 其他

## ObserverStatsLogic
options-observer-stats =
    .none = 无
    .basic = 基础
    .economy = 经济
    .production = 生产
    .support-powers = 支援技能
    .combat = 战斗
    .army = 军队
    .earnings-graph = 收入（图表）
    .army-graph = 军队（图表）

## WorldTooltipLogic
label-unrevealed-terrain = 未揭示地形

## KickClientLogic
dialog-kick-client =
    .prompt = 踢出 { $player }？

## KickSpectatorsLogic
dialog-kick-spectators =
    .prompt = 提示
    { $count ->
        [one] 确定要踢出 1 名观战者吗？
       *[other] 确定要踢出 { $count } 名观战者吗？
    }

## LobbyLogic
options-slot-admin =
    .add-bots = 添加 AI
    .remove-bots = 移除 AI
    .configure-bots = 配置 AI
    .teams-count = { $count } 支队伍
    .humans-vs-bots = 人类对 AI
    .free-for-all = 自由混战
    .configure-teams = 配置队伍

## LobbyLogic, InGameChatLogic
button-general-chat = 全部
button-team-chat = 队伍

## LobbyOptionsLogic, MissionBrowserLogic
label-not-available = 不可用

## LobbyUtils
options-lobby-slot =
    .slot = 槽位
    .open = 打开
    .closed = 已关闭
    .bots = AI
    .bots-disabled = AI 已禁用

## MapPreviewLogic
label-connecting = 正在连接…
label-downloading-map = 正在下载 { $size } kB
label-downloading-map-progress = 正在下载 { $size } kB（{ $progress }%）
button-retry-install = 重试安装
button-retry-search = 重试搜索
## also MapChooserLogic
label-created-by = 作者：{ $author }

## SpawnSelectorTooltipLogic
label-disabled-spawn = 禁用出生点
label-available-spawn = 可用出生点

## DisplaySettingsLogic
options-camera =
    .close = 关闭
    .medium = 中
    .far = 远
    .furthest = 最远

options-display-mode =
    .windowed = 窗口化
    .legacy-fullscreen = 全屏（旧版）
    .fullscreen = 全屏

label-video-display-index = 显示器 { $number }

options-status-bars =
    .standard = 标准
    .show-on-damage = 受损时显示
    .always-show = 始终显示

options-target-lines =
    .automatic = 自动
    .manual = 手动
    .disabled = 已禁用

checkbox-frame-limiter = 启用帧率限制（{ $fps } FPS）

## HotkeysSettingsLogic
label-original-notice = 默认设置为“{ $key }”
label-duplicate-notice = 该设置已被“{ $key }”用于 { $context } 上下文
hotkey-context-any = 任意

## GameplaySettingsLogic
auto-save-interval =
    .disabled = 已禁用
    .options = 选项
        { $seconds ->
            [one] 1 秒
           *[other] { $seconds } 秒
        }
    .minute-options =
        { $minutes ->
            [one] 1 分钟
           *[other] { $minutes } 分钟
        }

auto-save-max-file-number = { $saves } 个存档

## InputSettingsLogic
options-mouse-scroll-type =
    .disabled = 已禁用
    .standard = 标准
    .inverted = 反转
    .joystick = 手柄

## InputSettingsLogic, IntroductionPromptLogic
options-control-scheme =
    .classic = 经典
    .modern = 现代
    .otherrts = 其他 RTS

## SettingsLogic
dialog-settings-save =
    .title = 标题
    .prompt = 提示
    游戏重启后生效。
    .cancel = 继续

dialog-settings-restart =
    .title = 标题
    .prompt = 提示
    游戏重启后生效。立即重启？
    .confirm = 确定
    .cancel = 稍后重启

dialog-settings-reset =
    .title = 重置 { $panel }
    .prompt = 确定要重置此面板中的所有设置吗？
    .confirm = 重置
    .cancel = 取消

## AssetBrowserLogic
label-all-packages = 所有扩展包
label-length-in-seconds = { $length } 秒

## ConnectionLogic
label-connecting-to-endpoint = 正在连接 { $endpoint }…
label-could-not-connect-to-target = 无法连接到 { $target }
label-unknown-error = 未知错误
label-password-required = 需要密码
label-connection-failed = 连接失败
notification-mod-switch-failed = 切换模组失败。

## GameSaveBrowserLogic
dialog-rename-save =
    .title = 标题
    .prompt = 提示
    .confirm = 确定

dialog-delete-save =
    .title = 删除所选游戏存档？
    .prompt = 删除“{ $save }”。
    .confirm = 删除

dialog-delete-all-saves =
    .title = 标题
    .prompt = 提示
    { $count ->
        [one] 删除 { $count } 个存档。
       *[other] 删除 { $count } 个存档。
    }
    .confirm = 确定

notification-save-deletion-failed = 删除存档文件“{ $savePath }”失败。详情见日志。

dialog-overwrite-save =
    .title = 覆盖已保存的游戏？
    .prompt = 覆盖 { $file }？
    .confirm = 覆盖

## MainMenuLogic
label-loading-news = 正在加载新闻
label-news-retrieval-failed = 获取新闻失败：{ $message }
label-news-parsing-failed = 新闻解析失败：{ $message }
label-author-datetime = 由 { $author } 于 { $datetime } 创建

## MapChooserLogic
label-all-maps = 所有地图
label-no-matches = 无匹配项
label-player-count =
    { $players ->
        [one] { $players } 名玩家
       *[other] { $players } 名玩家
    }
label-map-size-huge = 巨大
label-map-size-large = 大
label-map-size-medium = 中
label-map-size-small = 小
label-map-searching-count =
    { $count ->
        [one] 正在 OpenRA 资源中心搜索 { $count } 张地图…
       *[other] 正在 OpenRA 资源中心搜索 { $count } 张地图…
    }
label-map-unavailable-count =
    { $count ->
        [one] OpenRA 资源中心未找到 { $count } 张地图
       *[other] OpenRA 资源中心未找到 { $count } 张地图
    }

notification-map-deletion-failed = 删除地图“{ $map }”失败。详情见 debug.log 文件。

dialog-delete-map =
    .title = 删除地图
    .prompt = 删除地图“{ $title }”？
    .confirm = 删除

dialog-delete-all-maps =
    .title = 标题
    .prompt = 提示
    .confirm = 确定

options-order-maps =
    .player-count = 玩家
    .title = 标题
    .date = 日期
    .size = 大小

button-mapchooser-system-maps-tab = 官方地图
button-mapchooser-remote-maps-tab = 服务器地图
button-mapchooser-user-maps-tab = 自定义地图
button-mapchooser-generated-maps-tab = 生成地图

## MissionBrowserLogic
dialog-no-video =
    .title = 标题
    .prompt = 提示
        游戏视频可以从
        “管理内容”菜单中安装。
    .cancel = 返回

dialog-cant-play-video =
    .title = 标题
    .prompt = 提示
    .cancel = 返回

## MusicPlayerLogic
label-sound-muted = 音频已在设置中被静音。
label-no-song-playing = 当前没有播放音乐

## MuteHotkeyLogic
label-audio-muted = 音频已静音。
label-audio-unmuted = 音频已取消静音。

## PlayerProfileLogic
label-loading-player-profile = 正在加载玩家资料…
label-loading-player-profile-failed = 加载玩家资料失败。

## ProductionTooltipLogic, EncyclopediaLogic
label-requires = 需要{ $prerequisites }。

## ReplayBrowserLogic
label-duration = 时长：{ $time }

options-replay-type =
    .singleplayer = 单人游戏
    .multiplayer = 多人游戏

options-winstate =
    .victory = 胜利
    .defeat = 失败

options-replay-date =
    .today = 今天
    .last-week = 最近 7 天
    .last-fortnight = 最近 14 天
    .last-month = 最近 30 天

options-replay-duration =
    .very-short = 5 分钟以内
    .short = 短（10 分钟）
    .medium = 中
    .long = 长（60 分钟以上）

dialog-rename-replay =
    .title = 标题
    .prompt = 提示
    .confirm = 确定

dialog-delete-replay =
    .title = 删除所选回放？
    .prompt = 删除回放 { $replay }？
    .confirm = 删除

dialog-delete-all-replays =
    .title = 标题
    .prompt = 提示
    { $count ->
        [one] 删除 { $count } 个回放。
       *[other] 删除 { $count } 个回放。
    }
    .confirm = 确定

notification-replay-deletion-failed = 删除回放文件“{ $file }”失败。详情见 debug.log 文件。

## ReplayUtils
-incompatible-replay-recorded = 该回放是用

dialog-incompatible-replay =
    .title = 标题
    .prompt = 提示
    .confirm = 确定
    .prompt-unknown-version = 该回放是用未知版本录制的。
    .prompt-unknown-mod = 该回放是用未知模组录制的。
    .prompt-unavailable-mod = 该回放是用不可用的模组录制的：{ $mod }。
    .prompt-incompatible-version = 该回放是用不兼容的版本录制的：
    { $version }.
    .prompt-unavailable-map = 该回放使用了不可用的地图：
    { $map }.

# SelectUnitsByTypeHotkeyLogic
nothing-selected = 未选择任何内容。

## SelectUnitsByTypeHotkeyLogic, SelectAllUnitsHotkeyLogic
selected-units-across-screen =
    { $units ->
        [one] 选中了屏幕上的 1 个单位。
       *[other] 选中了屏幕上的 { $units } 个单位。
    }

selected-units-across-map =
    { $units ->
        [one] 选中了地图上的 1 个单位。
       *[other] 选中了地图上的 { $units } 个单位。
    }

## ServerCreationLogic
label-internet-server-nat-A = 互联网服务器（UPnP/NAT-PMP
label-internet-server-nat-B-enabled = 已启用
label-internet-server-nat-B-not-supported = 不支持
label-internet-server-nat-B-disabled = 已禁用
label-internet-server-nat-C = ）：

label-local-server = 本地服务器：

dialog-server-creation-failed =
    .prompt = 无法监听端口 { $port }。
    .prompt-port-used = 请检查该端口是否已被占用。
    .prompt-error = 错误："{ $message }"（{ $code }）。
    .title = 服务器创建失败
    .cancel = 返回

## ServerListLogic
label-players-online-count =
    { $players ->
        [one] { $players } 名玩家在线
       *[other] { $players } 名玩家在线
    }

label-search-status-failed = 服务器列表查询失败。
label-search-status-no-games = 没有找到游戏。尝试更改筛选条件。
label-no-server-selected = 未选择服务器

label-map-status-searching = 搜索中…
label-map-classification-unknown = 未知地图

label-players-count =
    { $players ->
        [0] 无玩家
        [one] 1 名玩家
       *[other] { $players } 名玩家
    }

label-bots-count =
    { $bots ->
        [0] 无 AI
        [one] 1 个 AI
       *[other] { $bots } 个 AI
    }

## ServerListLogic, ReplayBrowserLogic, ObserverShroudSelectorLogic
label-players = 玩家

## ServerListLogic, GameInfoStatsLogic
label-spectators = 观战者
label-spectators-count =
    { $spectators ->
        [0] 无观战者
        [one] 1 名观战者
       *[other] { $spectators } 名观战者
    }

## ServerlistLogic, GameInfoStatsLogic, ObserverShroudSelectorLogic, SpawnSelectorTooltipLogic, ReplayBrowserLogic
label-team-name = 队伍 { $team }
label-no-team = 无队伍

label-playing = 播放中
label-waiting = 等待中

label-other-players-count =
    { $players ->
        [one] 其他 1 名玩家
       *[other] 其他 { $players } 名玩家
    }

label-in-progress-for =
    { $minutes ->
        [0] 进行中不足一分钟。
        [one] 进行中 { $minutes } 分钟。
       *[other] 进行中 { $minutes } 分钟。
    }

label-password-protected = 需要密码
label-waiting-for-players = 等待玩家
label-server-shutting-down = 服务器正在关闭
label-unknown-server-state = 未知服务器状态

## Game
notification-saved-screenshot = 已保存截图 { $filename }

## ChatCommands
notification-invalid-command = { $name } 不是有效命令。

## DebugVisualizationCommands
description-combat-geometry = 切换战斗几何覆盖层。
description-render-geometry = 切换渲染几何覆盖层。
description-screen-map-overlay = 切换屏幕地图覆盖层。
description-depth-buffer = 切换深度缓冲区覆盖层。
description-actor-tags-overlay = 切换单位标签覆盖层。

## DevCommands
notification-cheats-disabled = 已禁用作弊。
notification-invalid-cash-amount = 无效的金额。
description-toggle-visibility = 切换视野检查和缩略图。
description-give-cash = 提供默认或指定金额的资金。
description-give-cash-all = 向所有玩家和 AI 提供默认或指定金额的资金。
description-instant-building = 切换即时建造。
description-build-anywhere = 切换随处建造。
description-unlimited-power = 切换无限电力。
description-enable-tech = 切换可建造所有建筑。
description-fast-charge = 切换近乎即时的支援技能充能。
description-dev-cheat-all = 启用所有作弊并赠送一些资金。
description-dev-crash = 使游戏崩溃。
description-levelup-actor = 向所选单位增加指定等级。
description-player-experience = 向所选单位的拥有者增加指定数量的玩家经验值。
description-power-outage = 使所选单位的拥有者停电 5 秒。
description-kill-selected-actors = 杀死所选单位。
description-dispose-selected-actors = 销毁所选单位。

## HelpCommands
notification-available-commands = 以下是可用命令：
description-no-description = 无可用描述。
description-help-description = 提供各种命令的有用信息。

## PlayerCommands
description-pause-description = 暂停或继续游戏。
description-surrender-description = 自毁一切并输掉游戏。

## DeveloperMode
notification-cheat-used = 作弊已使用：{ $cheat }，由 { $player }{ $suffix }。

## CustomTerrainDebugOverlay
description-custom-terrain-debug-overlay = 切换自定义地形调试覆盖层。

## CellTriggerOverlay
description-cell-triggers-overlay = 切换脚本触发器覆盖层。

## HierarchicalPathFinderOverlay
description-hpf-debug-overlay = 切换分层寻路器覆盖层。

## PathFinderOverlay
description-path-debug-overlay = 切换寻路可视化。

## TerrainGeometryOverlay
description-terrain-geometry-overlay = 切换地形几何覆盖层。

## ActorMapOverlay
description-actor-map-overlay = 切换单位地图覆盖层。

## MapOptions, MissionBrowserLogic
options-game-speed =
    .slowest = 最慢
    .slower = 更慢
    .normal = 普通
    .fast = 快
    .faster = 更快
    .fastest = 最快

## TimeLimitManager
options-time-limit =
    .no-limit = 无限制
    .options = 选项
        { $minutes ->
            [one] { $minutes } 分钟
           *[other] { $minutes } 分钟
        }

notification-time-limit-expired = 时间限制已到期。

## EditorActorBrush
notification-added-actor = 已添加 { $name }（{ $id }）

## EditorCopyPasteBrush
notification-copied-tiles = 已复制 { $tiles } 个图块
notification-copied-actors = 已复制 { $actors } 个单位
notification-copied-tiles-actors = 已复制 { $tiles } 个图块和 { $actors } 个单位

## EditorDefaultBrush
notification-selected-area = 已选择区域 { $x },{ $y }（{ $width },{ $height }）
notification-removed-area = 已移除区域 { $x },{ $y }（{ $width },{ $height }）
notification-selected-actor = 已选择单位 { $id }
notification-cleared-selection = 已清除选择
notification-removed-actor = 已移除 { $name }（{ $id }）
notification-removed-resource = 已移除 { $type }
notification-moved-actor = 已将 { $id } 从 { $x1 },{ $y1 } 移动到 { $x2 },{ $y2 }

## EditorResourceBrush
notification-added-resource =
    { $count ->
       [one] 添加了 1 格 { $type }
      *[other] 添加了 { $count } 格 { $type }
    }

## EditorTileBrush
notification-added-tile = 已添加图块 { $id }
notification-filled-tile = 已填充图块 { $id }

## EditorMarkerLayerBrush
notification-added-marker-tiles-markers =
    .red = 红色
    .orange = 橙色
    .yellow = 黄色
    .green = 绿色
    .cyan = 青色
    .blue = 蓝色
    .purple = 紫色
    .magenta = 品红
notification-added-marker-tiles =
    { $count ->
       [one] 添加了 { $type } 标记图块
      *[other] 添加了 { $count } 个 { $type } 标记图块
    }
notification-removed-marker-tiles =
    { $count ->
       [one] 已移除标记图块
      *[other] 已移除 { $count } 个标记图块
    }
notification-cleared-selected-marker-tiles =
    { $count ->
       [one] 已清除 { $type } 标记图块
      *[other] 已清除 { $count } 个 { $type } 标记图块
    }
notification-cleared-all-marker-tiles = 已清除 { $count } 个标记图块

## EditorActionManager
notification-opened = 已打开

## MapOverlaysLogic
mirror-mode =
    .none = 无
    .flip = 翻转
    .rotate = 旋转

## ActorEditLogic
notification-edited-actor = 已编辑 { $name }（{ $id }）
notification-edited-actor-id = 已编辑 { $name }（{ $old-id }-> { $new-id }）

## ConquestVictoryConditions, StrategicVictoryConditions
notification-player-is-victorious = { $player } 已获胜。
notification-player-is-defeated = { $player } 已被击败。

## OrderManager
notification-desync-compare-logs = 第 { $frame } 帧不同步。
    请与其他玩家对比 syncreport.log。

## WidgetUtils
label-win-state-won = 胜利
label-win-state-lost = 失败
label-client-state-disconnected = 已断开连接

## Player
enumerated-bot-name =
    { $name } { $number ->
       *[zero] {""}
        [other] { $number }
    }

## ModifiersExts
keycode-modifier =
    .alt = Alt
    .ctrl = Ctrl
    .meta = Meta
    .cmd = Cmd
    .shift = Shift
    .none = 无

## KeycodeExts
keycode =
    .unknown = 未定义
    .return = 回车
    .escape = Esc
    .backspace = 退格
    .tab = 制表
    .space = 空格
    .exclaim = !
    .quotedbl = "
    .hash = #
    .percent = %
    .dollar = $
    .ampersand = &
    .quote = '
    .leftparen = (
    .rightparen = )
    .asterisk = *
    .plus = +
    .comma = ,
    .minus = -
    .period = .
    .slash = /
    .number_0 = 0
    .number_1 = 1
    .number_2 = 2
    .number_3 = 3
    .number_4 = 4
    .number_5 = 5
    .number_6 = 6
    .number_7 = 7
    .number_8 = 8
    .number_9 = 9
    .colon = :
    .semicolon = ;
    .less = <
    .equals = =
    .greater = >
    .question = ?
    .at = @
    .leftbracket = [
    .backslash = \
    .rightbracket = ]
    .caret = ^
    .underscore = _
    .backquote = `
    .a = A
    .b = B
    .c = C
    .d = D
    .e = E
    .f = F
    .g = G
    .h = H
    .i = I
    .j = J
    .k = K
    .l = L
    .m = M
    .n = N
    .o = O
    .p = P
    .q = Q
    .r = R
    .s = S
    .t = T
    .u = U
    .v = V
    .w = W
    .x = X
    .y = Y
    .z = Z
    .capslock = 大写锁定
    .f1 = F1
    .f2 = F2
    .f3 = F3
    .f4 = F4
    .f5 = F5
    .f6 = F6
    .f7 = F7
    .f8 = F8
    .f9 = F9
    .f10 = F10
    .f11 = F11
    .f12 = F12
    .printscreen = 截屏
    .scrolllock = 滚动锁定
    .pause = 暂停
    .insert = 插入
    .home = 主页
    .pageup = 上翻页
    .delete = 删除
    .end = 末尾
    .pagedown = 下翻页
    .right = 右
    .left = 左
    .down = 下
    .up = 上
    .numlockclear = 数字锁定
    .kp_divide = 小键盘除号
    .kp_multiply = 小键盘乘号
    .kp_minus = 小键盘减号
    .kp_plus = 小键盘加号
    .kp_enter = 小键盘回车
    .kp_1 = 小键盘 1
    .kp_2 = 小键盘 2
    .kp_3 = 小键盘 3
    .kp_4 = 小键盘 4
    .kp_5 = 小键盘 5
    .kp_6 = 小键盘 6
    .kp_7 = 小键盘 7
    .kp_8 = 小键盘 8
    .kp_9 = 小键盘 9
    .kp_0 = 小键盘 0
    .kp_period = 小键盘小数点
    .application = 应用程序
    .power = 电力
    .kp_equals = 小键盘等号
    .f13 = F13
    .f14 = F14
    .f15 = F15
    .f16 = F16
    .f17 = F17
    .f18 = F18
    .f19 = F19
    .f20 = F20
    .f21 = F21
    .f22 = F22
    .f23 = F23
    .f24 = F24
    .execute = 执行
    .help = 帮助
    .menu = 菜单
    .select = 选择
    .stop = 停止
    .again = 重试
    .undo = 撤销
    .cut = 剪切
    .copy = 复制
    .paste = 粘贴
    .find = 查找
    .mute = 静音
    .volumeup = 音量增大
    .volumedown = 音量减小
    .kp_comma = 小键盘逗号
    .kp_equalsas400 = 小键盘（AS400）
    .alterase = AltErase
    .sysreq = SysReq
    .cancel = 取消
    .clear = 清除
    .prior = 上一页
    .return2 = 回车
    .separator = 分隔符
    .out = 输出
    .oper = Oper
    .clearagain = 清除 / 重做
    .crsel = CrSel
    .exsel = ExSel
    .kp_00 = 小键盘 00
    .kp_000 = 小键盘 000
    .thousandsseparator = 千位分隔符
    .decimalseparator = 小数点
    .currencyunit = 货币单位
    .currencysubunit = 货币辅单位
    .kp_leftparen = 小键盘左括号
    .kp_rightparen = 小键盘右括号
    .kp_leftbrace = 小键盘左花括号
    .kp_rightbrace = 小键盘右花括号
    .kp_tab = 小键盘制表
    .kp_backspace = 小键盘退格
    .kp_a = 小键盘 A
    .kp_b = 小键盘 B
    .kp_c = 小键盘 C
    .kp_d = 小键盘 D
    .kp_e = 小键盘 E
    .kp_f = 小键盘 F
    .kp_xor = 小键盘异或
    .kp_power = 小键盘幂
    .kp_percent = 小键盘百分号
    .kp_less = 小键盘小于
    .kp_greater = 小键盘大于
    .kp_ampersand = 小键盘与
    .kp_dblampersand = 小键盘双与
    .kp_verticalbar = 小键盘或
    .kp_dblverticalbar = 小键盘双或
    .kp_colon = 小键盘冒号
    .kp_hash = 小键盘井号
    .kp_space = 小键盘空格
    .kp_at = 小键盘 @
    .kp_exclam = 小键盘感叹号
    .kp_memstore = 小键盘记忆存储
    .kp_memrecall = 小键盘记忆回读
    .kp_memclear = 小键盘记忆清除
    .kp_memadd = 小键盘记忆加
    .kp_memsubtract = 小键盘记忆减
    .kp_memmultiply = 小键盘记忆乘
    .kp_memdivide = 小键盘记忆除
    .kp_plusminus = 小键盘正负号
    .kp_clear = 小键盘清除
    .kp_clearentry = 小键盘清除输入
    .kp_binary = 小键盘二进制
    .kp_octal = 小键盘八进制
    .kp_decimal = 小键盘小数点
    .kp_hexadecimal = 小键盘十六进制
    .lctrl = 左 Ctrl
    .lshift = 左 Shift
    .lalt = 左 Alt
    .lgui = 左 GUI
    .rctrl = 右 Ctrl
    .rshift = 右 Shift
    .ralt = 右 Alt
    .rgui = 右 GUI
    .mode = 模式切换
    .audionext = 下一曲
    .audioprev = 上一曲
    .audiostop = 停止播放
    .audioplay = 播放
    .audiomute = 音频静音
    .mediaselect = 媒体选择
    .www = 网页
    .mail = 邮件
    .calculator = 计算器
    .computer = 电脑
    .ac_search = 搜索
    .ac_home = 主页
    .ac_back = 后退
    .ac_forward = 前进
    .ac_stop = 停止
    .ac_refresh = 刷新
    .ac_bookmarks = 书签
    .brightnessdown = 亮度减小
    .brightnessup = 亮度增大
    .displayswitch = 切换显示器
    .kbdillumtoggle = 键盘灯切换
    .kbdillumdown = 键盘灯调暗
    .kbdillumup = 键盘灯调亮
    .eject = 弹出
    .sleep = 休眠
    .mouse4 = 鼠标 4
    .mouse5 = 鼠标 5

## MapGeneratorToolLogic
notification-map-generator-generated = 使用 { $name } 生成

dialog-notification-map-generator-failed =
    .title = 标题
    .prompt = 提示
    .cancel = 关闭

## EditorTilingPathBrush
notification-tiling-path-started = 已开始铺设路径
notification-tiling-path-updated = 已更新铺设路径
notification-tiling-path-reset = 已放弃铺设路径
notification-tiling-path-painted = 已绘制铺设路径
