using System.Reflection;
using OpenRA;
using OpenRA.Network;
using OpenRA.Server;
using OpenRA.Primitives;

if(args.Length!=1) throw new ArgumentException("Pass the extracted package's mono/openra directory.");
if(!new GraphicSettings().DisableHardwareCursors||!new GameSettings().PauseShellmap)
    throw new Exception("Expected SWITCH performance defaults in the loaded assembly.");
Platform.OverrideEngineDir(Path.GetFullPath(args[0]));
Platform.OverrideSupportDir(Path.Combine(Platform.EngineDir,"Support"));
Game.InitializeSettings(Arguments.Empty);
if(Platform.CurrentPlatform!=PlatformType.Linux||Platform.OperatingSystem!="Nintendo Switch")
    throw new Exception("Original Switch platform compatibility was not restored.");
var expectedSupport=Path.Combine(Platform.EngineDir,"Support")+Path.DirectorySeparatorChar;
if(Platform.GetSupportDir(SupportDirType.ModernUser)!=expectedSupport)
    throw new Exception("Switch support directory compatibility was not restored.");
Log.AddChannel("debug",null);
Log.AddChannel("perf",null);
Log.AddChannel("client",null);
var mods=new InstalledMods(new[]{Path.Combine(Platform.EngineDir,"mods")},Array.Empty<string>());
using var data=Game.ModData=new ModData(mods["ra"],mods);
data.MapCache.LoadPreviewImages=false;
data.MapCache.LoadMaps(data);

Game.LocalPlayerProfile = new LocalPlayerProfile(Path.Combine(Platform.SupportDir, "test-no-keys"), data.GetOrCreate<PlayerDatabase>());
var map = data.MapCache.First(m => m.Uid == "b2ce921eb06ff3529d81a3755f75777240068a35");
if (data.MapCache.GetUpdatedMap(map.Uid) != map.Uid) throw new Exception("Mission refresh failed");
Game.CreateAndStartLocalServer(map.Uid, new[]{Order.Command("option difficulty normal"), Order.Command("state 2")});
var server = (Server)typeof(Game).GetField("server",BindingFlags.Static|BindingFlags.NonPublic)!.GetValue(null)!;
var om = (OrderManager)typeof(Game).GetField("OrderManager", BindingFlags.Static|BindingFlags.NonPublic)!.GetValue(null)!;
var timer = System.Diagnostics.Stopwatch.StartNew();
while (server.State != ServerState.GameStarted && timer.ElapsedMilliseconds < 20000)
{
    om.TickImmediate();
    Thread.Sleep(20);
}
if (server.State != ServerState.GameStarted) throw new Exception("Campaign launch stalled: clients=" + server.Conns.Count + "; state=" + string.Join(",",server.LobbyInfo.Clients.Select(c=>c.State)));
Console.WriteLine("PASS campaign: actual CreateAndStartLocalServer, OrderManager, automatic handshake, lobby callback, mission options and ready command start the server.");
om.Dispose();
Game.CloseServer();
Log.Dispose();
