## Buttons
button-cancel = 取消
button-retry = 重试
button-back = 返回
button-continue = 继续
button-quit = 退出

## Server Orders
notification-custom-rules = This map contains custom rules. Game experience may change.
notification-two-humans-required = 此服务器至少需要两名真人玩家才能开始对局。
notification-unknown-server-command = Unknown server command: { $command }.
notification-admin-start-game = 只有房主才能开始游戏。
notification-no-start-until-required-slots-full = 必需槽位未满，无法开始游戏。
notification-no-start-without-players = 没有玩家时无法开始游戏。
notification-insufficient-enabled-spawn-points = 需要启用更多出生点才能开始游戏。
notification-malformed-command = Malformed { $command } command.
notification-state-unchanged-ready = Cannot change state when marked as ready.
notification-invalid-faction-selected = 无效的阵营选择：{ $faction }。
notification-state-unchanged-game-started = State cannot be changed once the game has started ({ $command }).
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
        [one] { $player } will be dropped in { $timeout } second.
       *[other] { $player } will be dropped in { $timeout } seconds.
    }
notification-error-game-started = 游戏已经开始。
notification-requires-password = 服务器需要密码。
notification-incorrect-password = 密码错误。
notification-incompatible-mod = 服务器正在运行不兼容的模组。
notification-incompatible-version = 服务器正在运行不兼容的版本。
notification-incompatible-protocol = Server is running an incompatible protocol.
notification-you-were-banned = 您已被封禁。
notification-you-were-temp-banned = 您已被临时封禁。
notification-game-full = 游戏已满。
notification-new-admin = { $player } 现在是管理员。
notification-invalid-configuration-command = Invalid configuration command.
notification-admin-option = 只有房主才能设置该选项。
notification-error-number-teams = Could not parse the number of teams: { $raw }.
notification-admin-kick = 只有房主才能踢出玩家。
notification-kick-self = 房主不能踢出自己。
notification-kick-none = 该槽位无人。
notification-no-kick-game-started = 游戏开始后只能踢出观战者和已战败玩家。
notification-admin-clear-spawn = 只有管理员才能清除出生点。
notification-spawn-occupied = 您不能与其他玩家占用同一出生点。
notification-spawn-locked = 该出生点已锁定给其他玩家槽位。
notification-admin-lobby-info = Only the host can set lobby info.
notification-invalid-lobby-info = Invalid lobby info sent.
notification-player-color-terrain = 颜色已调整，以降低与地形的相似度。
notification-player-color-player = 颜色已调整，以降低与其他玩家的相似度。
notification-invalid-player-color = 无法确定有效的玩家颜色，已选择随机颜色。
notification-invalid-error-code = Failed to parse error message.
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
        [one] Chat is disabled. Please try again in { $remaining } second.
       *[other] Chat is disabled. Please try again in { $remaining } seconds.
    }

## VoteKickTracker
notification-unable-to-start-a-vote = Unable to start a vote.
notification-insufficient-votes-to-kick = Insufficient votes to kick player { $kickee }.
notification-kick-already-voted = You have already voted.
notification-vote-kick-started = Player { $kicker } has started a vote to kick player { $kickee }.
notification-vote-kick-in-progress = { $percentage }% of players have voted to kick player { $kickee }.
notification-vote-kick-ended = Vote to kick player { $kickee } has failed.

## ActorEditLogic
label-duplicate-actor-id = 重复的单位 ID
label-actor-id = 输入单位 ID
label-actor-owner = 所有者

## ActorSelectorLogic
label-actor-type = Type: { $actorType }

## CommonSelectorLogic
options-common-selector =
    .search-results = Search Results
    .all = All
    .multiple = Multiple
    .none = None

## SaveMapLogic
label-unpacked-map = 解包

dialog-save-map-failed =
    .title = Failed to save map
    .prompt = See debug.log for details.
    .confirm = OK

dialog-overwrite-map-failed =
    .title = Warning
    .prompt = By saving you will overwrite
    an already existing map.
    .confirm = Save

dialog-overwrite-map-outside-edit =
    .title = Warning
    .prompt = The map has been edited from outside the editor.
    By saving you may overwrite progress.
    .confirm = Save

notification-save-current-map = Saved current map.

## GameInfoLogic
menu-game-info =
    .objectives = Objectives
    .briefing = Briefing
    .options = Options
    .debug = Debug
    .chat = Chat

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
    .title = Kick { $player }?
    .prompt = This player will not be able to rejoin the game.
    .confirm = Kick

dialog-vote-kick =
    .title = Vote to kick { $player }?
    .prompt = This player will not be able to rejoin the game.
    .prompt-break-bots =
    { $bots ->
        [one] Kicking the game admin will also kick 1 bot.
       *[other] Kicking the game admin will also kick { $bots } bots.
    }
    .vote-start = Start Vote
    .vote-for = Vote For
    .vote-against = Vote Against
    .vote-cancel = Abstain

notification-vote-kick-disabled = 此服务器已禁用投票踢人。

## GameTimerLogic
label-paused = 已暂停
label-max-speed = 最大速度
label-replay-speed = { $percentage }% Speed
label-replay-complete = { $percentage }% complete

## LobbyLogic, InGameChatLogic
label-chat-disabled = 聊天已禁用
label-chat-availability =
    { $seconds ->
        [one] Chat available in { $seconds } second...
       *[other] Chat available in { $seconds } seconds...
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
    .title = Leave Mission
    .prompt = Leave this game and return to the menu?
    .confirm = Leave
    .cancel = Stay

dialog-restart-mission =
    .title = Restart
    .prompt = Are you sure you want to restart?
    .confirm = Restart
    .cancel = Stay

dialog-surrender =
    .title = Surrender
    .prompt = Are you sure you want to surrender?
    .confirm = Surrender
    .cancel = Stay

dialog-error-max-player =
    .title = Error: Max player count exceeded
    .prompt = There are too many players defined ({ $players }/{ $max }).
    .confirm = Back

dialog-exit-map-editor =
    .title = Exit Map Editor
    .prompt-unsaved = Exit and lose all unsaved changes?
    .prompt-deleted = The map may have been deleted outside the editor
    .confirm-anyway = Exit anyway
    .confirm = Exit

dialog-play-map-warning =
    .title = Warning
    .prompt = The map may have been deleted or contains
    errors that prevent it from being loaded.
    .cancel = Okay

dialog-exit-to-map-editor =
    .title = Leave Mission
    .prompt = Leave this game and return to the editor?
    .confirm = Back To Editor
    .cancel = Stay

## IngamePowerBarLogic
## IngamePowerCounterLogic
label-power-usage = Power Usage: { $usage }/{ $capacity }
label-infinite-power = Infinite

## IngameSiloBarLogic
## IngameCashCounterLogic
label-silo-usage = Silo Usage: { $usage }/{ $capacity }

## ObserverShroudSelectorLogic
options-shroud-selector =
    .all-players = All Players
    .disable-shroud = Disable Shroud
    .other = Other

## ObserverStatsLogic
options-observer-stats =
    .none = Information: None
    .basic = Basic
    .economy = Economy
    .production = Production
    .support-powers = Support Powers
    .combat = Combat
    .army = Army
    .earnings-graph = Earnings (graph)
    .army-graph = Army (graph)

## WorldTooltipLogic
label-unrevealed-terrain = Unrevealed Terrain

## KickClientLogic
dialog-kick-client =
    .prompt = Kick { $player }?

## KickSpectatorsLogic
dialog-kick-spectators =
    .prompt =
    { $count ->
        [one] Are you sure you want to kick one spectator?
       *[other] Are you sure you want to kick { $count } spectators?
    }

## LobbyLogic
options-slot-admin =
    .add-bots = Add
    .remove-bots = Remove
    .configure-bots = Configure Bots
    .teams-count = { $count } Teams
    .humans-vs-bots = Humans vs Bots
    .free-for-all = Free for all
    .configure-teams = Configure Teams

## LobbyLogic, InGameChatLogic
button-general-chat = All
button-team-chat = Team

## LobbyOptionsLogic, MissionBrowserLogic
label-not-available = Not Available

## LobbyUtils
options-lobby-slot =
    .slot = Slot
    .open = Open
    .closed = Closed
    .bots = Bots
    .bots-disabled = Bots Disabled

## MapPreviewLogic
label-connecting = Connecting...
label-downloading-map = Downloading { $size } kB
label-downloading-map-progress = Downloading { $size } kB ({ $progress }%)
button-retry-install = Retry Install
button-retry-search = Retry Search
## also MapChooserLogic
label-created-by = Created by { $author }

## SpawnSelectorTooltipLogic
label-disabled-spawn = Disabled spawn
label-available-spawn = Available spawn

## DisplaySettingsLogic
options-camera =
    .close = Close
    .medium = Medium
    .far = Far
    .furthest = Furthest

options-display-mode =
    .windowed = Windowed
    .legacy-fullscreen = Fullscreen (Legacy)
    .fullscreen = Fullscreen

label-video-display-index = Display { $number }

options-status-bars =
    .standard = Standard
    .show-on-damage = Show On Damage
    .always-show = Always Show

options-target-lines =
    .automatic = Automatic
    .manual = Manual
    .disabled = Disabled

checkbox-frame-limiter = Enable Frame Limiter ({ $fps } FPS)

## HotkeysSettingsLogic
label-original-notice = The default is "{ $key }"
label-duplicate-notice = This is already used for "{ $key }" in the { $context } context
hotkey-context-any = Any

## GameplaySettingsLogic
auto-save-interval =
    .disabled = Disabled
    .options =
        { $seconds ->
            [one] 1 second
           *[other] { $seconds } seconds
        }
    .minute-options =
        { $minutes ->
            [one] 1 minute
           *[other] { $minutes } minutes
        }

auto-save-max-file-number = { $saves } saves

## InputSettingsLogic
options-mouse-scroll-type =
    .disabled = Disabled
    .standard = Standard
    .inverted = Inverted
    .joystick = Joystick

## InputSettingsLogic, IntroductionPromptLogic
options-control-scheme =
    .classic = Classic
    .modern = Modern
    .otherrts = Other RTS

## SettingsLogic
dialog-settings-save =
    .title = Restart Required
    .prompt = Some changes will not be applied until
    the game is restarted.
    .cancel = Continue

dialog-settings-restart =
    .title = Restart Now?
    .prompt = Some changes will not be applied until
    the game is restarted. Restart now?
    .confirm = Restart Now
    .cancel = Restart Later

dialog-settings-reset =
    .title = Reset { $panel }
    .prompt = Are you sure you want to reset
    all settings in this panel?
    .confirm = Reset
    .cancel = Cancel

## AssetBrowserLogic
label-all-packages = All Packages
label-length-in-seconds = { $length } sec

## ConnectionLogic
label-connecting-to-endpoint = Connecting to { $endpoint }...
label-could-not-connect-to-target = Could not connect to { $target }
label-unknown-error = Unknown error
label-password-required = Password Required
label-connection-failed = Connection Failed
notification-mod-switch-failed = Failed to switch mod.

## GameSaveBrowserLogic
dialog-rename-save =
    .title = Rename Save
    .prompt = Enter a new file name:
    .confirm = Rename

dialog-delete-save =
    .title = Delete selected game save?
    .prompt = Delete '{ $save }'.
    .confirm = Delete

dialog-delete-all-saves =
    .title = Delete all game saves?
    .prompt =
    { $count ->
        [one] Delete { $count } save.
       *[other] Delete { $count } saves.
    }
    .confirm = Delete All

notification-save-deletion-failed = Failed to delete save file '{ $savePath }'. See the logs for details.

dialog-overwrite-save =
    .title = Overwrite saved game?
    .prompt = Overwrite { $file }?
    .confirm = Overwrite

## MainMenuLogic
label-loading-news = Loading news
label-news-retrieval-failed = Failed to retrieve news: { $message }
label-news-parsing-failed = Failed to parse news: { $message }
label-author-datetime = by { $author } at { $datetime }

## MapChooserLogic
label-all-maps = All Maps
label-no-matches = No matches
label-player-count =
    { $players ->
        [one] { $players } Player
       *[other] { $players } Players
    }
label-map-size-huge = Huge
label-map-size-large = Large
label-map-size-medium = Medium
label-map-size-small = Small
label-map-searching-count =
    { $count ->
        [one] Searching the OpenRA Resource Center for { $count } map...
       *[other] Searching the OpenRA Resource Center for { $count } maps...
    }
label-map-unavailable-count =
    { $count ->
        [one] { $count } map was not found on the OpenRA Resource Center
       *[other] { $count } maps were not found on the OpenRA Resource Center
    }

notification-map-deletion-failed = Failed to delete map '{ $map }'. See the debug.log file for details.

dialog-delete-map =
    .title = Delete map
    .prompt = Delete the map '{ $title }'?
    .confirm = Delete

dialog-delete-all-maps =
    .title = Delete maps
    .prompt = Delete all maps on this page?
    .confirm = Delete

options-order-maps =
    .player-count = Players
    .title = Title
    .date = Date
    .size = Size

button-mapchooser-system-maps-tab = Official Maps
button-mapchooser-remote-maps-tab = Server Maps
button-mapchooser-user-maps-tab = Custom Maps
button-mapchooser-generated-maps-tab = Generate Map

## MissionBrowserLogic
dialog-no-video =
    .title = Video not installed
    .prompt =
        The game videos can be installed from the
        "Manage Content" menu.
    .cancel = Back

dialog-cant-play-video =
    .title = Unable to play video
    .prompt = Something went wrong during video playback.
    .cancel = Back

## MusicPlayerLogic
label-sound-muted = Audio has been muted in settings.
label-no-song-playing = No song is playing

## MuteHotkeyLogic
label-audio-muted = Audio muted.
label-audio-unmuted = Audio unmuted.

## PlayerProfileLogic
label-loading-player-profile = Loading player profile...
label-loading-player-profile-failed = Failed to load player profile.

## ProductionTooltipLogic, EncyclopediaLogic
label-requires = Requires { $prerequisites }.

## ReplayBrowserLogic
label-duration = Duration: { $time }

options-replay-type =
    .singleplayer = Singleplayer
    .multiplayer = Multiplayer

options-winstate =
    .victory = Victory
    .defeat = Defeat

options-replay-date =
    .today = Today
    .last-week = Last 7 days
    .last-fortnight = Last 14 days
    .last-month = Last 30 days

options-replay-duration =
    .very-short = Under 5 min
    .short = Short (10 min)
    .medium = Medium (30 min)
    .long = Long (60+ min)

dialog-rename-replay =
    .title = Rename Replay
    .prompt = Enter a new file name:
    .confirm = Rename

dialog-delete-replay =
    .title = Delete selected replay?
    .prompt = Delete replay { $replay }?
    .confirm = Delete

dialog-delete-all-replays =
    .title = Delete all selected replays?
    .prompt =
    { $count ->
        [one] Delete { $count } replay.
       *[other] Delete { $count } replays.
    }
    .confirm = Delete All

notification-replay-deletion-failed = Failed to delete replay file '{ $file }'. See the debug.log file for details.

## ReplayUtils
-incompatible-replay-recorded = It was recorded with

dialog-incompatible-replay =
    .title = Incompatible Replay
    .prompt = Replay metadata could not be read.
    .confirm = OK
    .prompt-unknown-version = { -incompatible-replay-recorded } an unknown version.
    .prompt-unknown-mod = { -incompatible-replay-recorded } an unknown mod.
    .prompt-unavailable-mod = { -incompatible-replay-recorded } an unavailable mod: { $mod }.
    .prompt-incompatible-version = { -incompatible-replay-recorded } an incompatible version:
    { $version }.
    .prompt-unavailable-map = { -incompatible-replay-recorded } an unavailable map:
    { $map }.

# SelectUnitsByTypeHotkeyLogic
nothing-selected = Nothing selected.

## SelectUnitsByTypeHotkeyLogic, SelectAllUnitsHotkeyLogic
selected-units-across-screen =
    { $units ->
        [one] Selected one unit across screen.
       *[other] Selected { $units } units across screen.
    }

selected-units-across-map =
    { $units ->
        [one] Selected one unit across map.
       *[other] Selected { $units } units across map.
    }

## ServerCreationLogic
label-internet-server-nat-A = Internet Server (UPnP/NAT-PMP
label-internet-server-nat-B-enabled = Enabled
label-internet-server-nat-B-not-supported = Not Supported
label-internet-server-nat-B-disabled = Disabled
label-internet-server-nat-C = ):

label-local-server = Local Server:

dialog-server-creation-failed =
    .prompt = Could not listen on port { $port }.
    .prompt-port-used = Check if the port is already being used.
    .prompt-error = Error is: "{ $message }" ({ $code }).
    .title = Server Creation Failed
    .cancel = Back

## ServerListLogic
label-players-online-count =
    { $players ->
        [one] { $players } Player Online
       *[other] { $players } Players Online
    }

label-search-status-failed = Failed to query server list.
label-search-status-no-games = No games found. Try changing filters.
label-no-server-selected = No Server Selected

label-map-status-searching = Searching...
label-map-classification-unknown = Unknown Map

label-players-count =
    { $players ->
        [0] No Players
        [one] One Player
       *[other] { $players } Players
    }

label-bots-count =
    { $bots ->
        [0] No Bots
        [one] One Bot
       *[other] { $bots } Bots
    }

## ServerListLogic, ReplayBrowserLogic, ObserverShroudSelectorLogic
label-players = Players

## ServerListLogic, GameInfoStatsLogic
label-spectators = Spectators
label-spectators-count =
    { $spectators ->
        [0] No Spectators
        [one] One Spectator
       *[other] { $spectators } Spectators
    }

## ServerlistLogic, GameInfoStatsLogic, ObserverShroudSelectorLogic, SpawnSelectorTooltipLogic, ReplayBrowserLogic
label-team-name = Team { $team }
label-no-team = No Team

label-playing = Playing
label-waiting = Waiting

label-other-players-count =
    { $players ->
        [one] One other player
       *[other] { $players } other players
    }

label-in-progress-for =
    { $minutes ->
        [0] In progress for less than a minute.
        [one] In progress for { $minutes } minute.
       *[other] In progress for { $minutes } minutes.
    }

label-password-protected = Password protected
label-waiting-for-players = Waiting for players
label-server-shutting-down = Server shutting down
label-unknown-server-state = Unknown server state

## Game
notification-saved-screenshot = Saved screenshot { $filename }

## ChatCommands
notification-invalid-command = { $name } is not a valid command.

## DebugVisualizationCommands
description-combat-geometry = toggles combat geometry overlay.
description-render-geometry = toggles render geometry overlay.
description-screen-map-overlay = toggles screen map overlay.
description-depth-buffer = toggles depth buffer overlay.
description-actor-tags-overlay = toggles actor tags overlay.

## DevCommands
notification-cheats-disabled = Cheats are disabled.
notification-invalid-cash-amount = Invalid cash amount.
description-toggle-visibility = toggles visibility checks and minimap.
description-give-cash = gives the default or specified amount of money.
description-give-cash-all = gives the default or specified amount of money to all players and AI.
description-instant-building = toggles instant building.
description-build-anywhere = toggles the ability to build anywhere.
description-unlimited-power = toggles infinite power.
description-enable-tech = toggles the ability to build everything.
description-fast-charge = toggles near-instant support power charging.
description-dev-cheat-all = toggles all cheats and gives you some cash for your trouble.
description-dev-crash = crashes the game.
description-levelup-actor = adds a specified number of levels to the selected actors.
description-player-experience = adds a specified amount of player experience to the owner(s) of selected actors.
description-power-outage = causes a 5-second power outage for the owner(s) of selected actors.
description-kill-selected-actors = kills selected actors.
description-dispose-selected-actors = disposes selected actors.

## HelpCommands
notification-available-commands = Here are the available commands:
description-no-description = no description available.
description-help-description = provides useful info about various commands.

## PlayerCommands
description-pause-description = pause or unpause the game.
description-surrender-description = self-destruct everything and lose the game.

## DeveloperMode
notification-cheat-used = Cheat used: { $cheat } by { $player }{ $suffix }.

## CustomTerrainDebugOverlay
description-custom-terrain-debug-overlay = toggles the custom terrain debug overlay.

## CellTriggerOverlay
description-cell-triggers-overlay = toggles the script triggers overlay.

## HierarchicalPathFinderOverlay
description-hpf-debug-overlay = toggles the hierarchical pathfinder overlay.

## PathFinderOverlay
description-path-debug-overlay = toggles a visualization of path searching.

## TerrainGeometryOverlay
description-terrain-geometry-overlay = toggles the terrain geometry overlay.

## ActorMapOverlay
description-actor-map-overlay = toggles the actor map overlay.

## MapOptions, MissionBrowserLogic
options-game-speed =
    .slowest = Slowest
    .slower = Slower
    .normal = Normal
    .fast = Fast
    .faster = Faster
    .fastest = Fastest

## TimeLimitManager
options-time-limit =
    .no-limit = No limit
    .options =
        { $minutes ->
            [one] { $minutes } minute
           *[other] { $minutes } minutes
        }

notification-time-limit-expired = Time limit has expired.

## EditorActorBrush
notification-added-actor = Added { $name } ({ $id })

## EditorCopyPasteBrush
notification-copied-tiles = Copied { $tiles } tiles
notification-copied-actors = Copied { $actors } actors
notification-copied-tiles-actors = Copied { $tiles } tiles and { $actors } actors

## EditorDefaultBrush
notification-selected-area = Selected area { $x },{ $y } ({ $width },{ $height })
notification-removed-area = Removed area { $x },{ $y } ({ $width },{ $height })
notification-selected-actor = Selected actor { $id }
notification-cleared-selection = Cleared selection
notification-removed-actor = Removed { $name } ({ $id })
notification-removed-resource = Removed { $type }
notification-moved-actor = Moved { $id } from { $x1 },{ $y1 } to { $x2 },{ $y2 }

## EditorResourceBrush
notification-added-resource =
    { $count ->
       [one] Added one cell of { $type }
      *[other] Added { $count } cells of { $type }
    }

## EditorTileBrush
notification-added-tile = Added tile { $id }
notification-filled-tile = Filled with tile { $id }

## EditorMarkerLayerBrush
notification-added-marker-tiles-markers =
    .red = red
    .orange = orange
    .yellow = yellow
    .green = green
    .cyan = cyan
    .blue = blue
    .purple = purple
    .magenta = magenta
notification-added-marker-tiles =
    { $count ->
       [one] Added { $type } marker tile
      *[other] Added { $count } { $type } marker tiles
    }
notification-removed-marker-tiles =
    { $count ->
       [one] Removed marker tile
      *[other] Removed { $count } marker tiles
    }
notification-cleared-selected-marker-tiles =
    { $count ->
       [one] Cleared { $type } marker tile
      *[other] Cleared { $count } { $type } marker tiles
    }
notification-cleared-all-marker-tiles = Cleared { $count } marker tiles

## EditorActionManager
notification-opened = Opened

## MapOverlaysLogic
mirror-mode =
    .none = None
    .flip = Flip
    .rotate = Rotate

## ActorEditLogic
notification-edited-actor = Edited { $name } ({ $id })
notification-edited-actor-id = Edited { $name } ({ $old-id }-> { $new-id })

## ConquestVictoryConditions, StrategicVictoryConditions
notification-player-is-victorious = { $player } is victorious.
notification-player-is-defeated = { $player } is defeated.

## OrderManager
notification-desync-compare-logs = Out of sync in frame { $frame }.
    Compare syncreport.log with other players.

## WidgetUtils
label-win-state-won = Won
label-win-state-lost = Lost
label-client-state-disconnected = Gone

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
    .none = None

## KeycodeExts
keycode =
    .unknown = Undefined
    .return = Return
    .escape = Escape
    .backspace = Backspace
    .tab = Tab
    .space = Space
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
    .capslock = CapsLock
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
    .printscreen = PrintScreen
    .scrolllock = ScrollLock
    .pause = Pause
    .insert = Insert
    .home = Home
    .pageup = PageUp
    .delete = Delete
    .end = End
    .pagedown = PageDown
    .right = Right
    .left = Left
    .down = Down
    .up = Up
    .numlockclear = Numlock
    .kp_divide = Keypad /
    .kp_multiply = Keypad *
    .kp_minus = Keypad -
    .kp_plus = Keypad +
    .kp_enter = Keypad Enter
    .kp_1 = Keypad 1
    .kp_2 = Keypad 2
    .kp_3 = Keypad 3
    .kp_4 = Keypad 4
    .kp_5 = Keypad 5
    .kp_6 = Keypad 6
    .kp_7 = Keypad 7
    .kp_8 = Keypad 8
    .kp_9 = Keypad 9
    .kp_0 = Keypad 0
    .kp_period = Keypad .
    .application = Application
    .power = Power
    .kp_equals = Keypad =
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
    .execute = Execute
    .help = Help
    .menu = Menu
    .select = Select
    .stop = Stop
    .again = Again
    .undo = Undo
    .cut = Cut
    .copy = Copy
    .paste = Paste
    .find = Find
    .mute = Mute
    .volumeup = VolumeUp
    .volumedown = VolumeDown
    .kp_comma = Keypad ,
    .kp_equalsas400 = Keypad (AS400)
    .alterase = AltErase
    .sysreq = SysReq
    .cancel = Cancel
    .clear = Clear
    .prior = Prior
    .return2 = Return
    .separator = Separator
    .out = Out
    .oper = Oper
    .clearagain = Clear / Again
    .crsel = CrSel
    .exsel = ExSel
    .kp_00 = Keypad 00
    .kp_000 = Keypad 000
    .thousandsseparator = ThousandsSeparator
    .decimalseparator = DecimalSeparator
    .currencyunit = CurrencyUnit
    .currencysubunit = CurrencySubUnit
    .kp_leftparen = Keypad (
    .kp_rightparen = Keypad )
    .kp_leftbrace = Keypad {"{"}
    .kp_rightbrace = Keypad {"}"}
    .kp_tab = Keypad Tab
    .kp_backspace = Keypad Backspace
    .kp_a = Keypad A
    .kp_b = Keypad B
    .kp_c = Keypad C
    .kp_d = Keypad D
    .kp_e = Keypad E
    .kp_f = Keypad F
    .kp_xor = Keypad XOR
    .kp_power = Keypad ^
    .kp_percent = Keypad %
    .kp_less = Keypad <
    .kp_greater = Keypad >
    .kp_ampersand = Keypad &
    .kp_dblampersand = Keypad &&
    .kp_verticalbar = Keypad |
    .kp_dblverticalbar = Keypad ||
    .kp_colon = Keypad :
    .kp_hash = Keypad #
    .kp_space = Keypad Space
    .kp_at = Keypad @
    .kp_exclam = Keypad !
    .kp_memstore = Keypad MemStore
    .kp_memrecall = Keypad MemRecall
    .kp_memclear = Keypad MemClear
    .kp_memadd = Keypad MemAdd
    .kp_memsubtract = Keypad MemSubtract
    .kp_memmultiply = Keypad MemMultiply
    .kp_memdivide = Keypad MemDivide
    .kp_plusminus = Keypad +/-
    .kp_clear = Keypad Clear
    .kp_clearentry = Keypad ClearEntry
    .kp_binary = Keypad Binary
    .kp_octal = Keypad Octal
    .kp_decimal = Keypad Decimal
    .kp_hexadecimal = Keypad Hexadecimal
    .lctrl = Left Ctrl
    .lshift = Left Shift
    .lalt = Left Alt
    .lgui = Left GUI
    .rctrl = Right Ctrl
    .rshift = Right Shift
    .ralt = Right Alt
    .rgui = Right GUI
    .mode = ModeSwitch
    .audionext = AudioNext
    .audioprev = AudioPrev
    .audiostop = AudioStop
    .audioplay = AudioPlay
    .audiomute = AudioMute
    .mediaselect = MediaSelect
    .www = WWW
    .mail = Mail
    .calculator = Calculator
    .computer = Computer
    .ac_search = AC Search
    .ac_home = AC Home
    .ac_back = AC Back
    .ac_forward = AC Forward
    .ac_stop = AC Stop
    .ac_refresh = AC Refresh
    .ac_bookmarks = AC Bookmarks
    .brightnessdown = BrightnessDown
    .brightnessup = BrightnessUp
    .displayswitch = DisplaySwitch
    .kbdillumtoggle = KBDIllumToggle
    .kbdillumdown = KBDIllumDown
    .kbdillumup = KBDIllumUp
    .eject = Eject
    .sleep = Sleep
    .mouse4 = Mouse 4
    .mouse5 = Mouse 5

## MapGeneratorToolLogic
notification-map-generator-generated = Generated using { $name }

dialog-notification-map-generator-failed =
    .title = Map generation failed
    .prompt = See debug.log for details.
    .cancel = Dismiss

## EditorTilingPathBrush
notification-tiling-path-started = Started tiling path
notification-tiling-path-updated = Updated tiling path
notification-tiling-path-reset = Discarded tiling path
notification-tiling-path-painted = Painted tiling path
