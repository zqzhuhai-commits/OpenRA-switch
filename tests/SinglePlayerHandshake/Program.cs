using System.Reflection;
using OpenRA;
using OpenRA.Network;
using OpenRA.Server;
using OpenRA.Primitives;

static void Wait(Func<bool> condition,string message)
{
    if(!SpinWait.SpinUntil(condition,20000)) throw new Exception(message);
}
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
string[] maps={
    data.MapCache.First(m=>m.Status==MapStatus.Available&&m.Categories.Contains("Conquest")).Uid,
    data.MapCache.First(m=>m.Status==MapStatus.Available&&m.Categories.Contains("Campaign")).Uid
};
var serverField=typeof(Game).GetField("server",BindingFlags.Static|BindingFlags.NonPublic)!;
for(int iteration=0;iteration<2;iteration++)
{
    var target=Game.CreateLocalServer(maps[iteration],isSkirmish:iteration==0);
    var server=(Server)serverField.GetValue(null)!;
    using IConnection client=new NetworkConnection(target);
    var network=(NetworkConnection)client;
    Wait(()=>network.ConnectionState==ConnectionState.Connected,"Header handshake failed: "+network.ErrorMessage);
    var handshake=new HandshakeResponse{
        Mod="ra",Version=data.Manifest.Metadata.Version,OrdersProtocol=ProtocolVersion.Orders,
        Client=new Session.Client{Name="Offline regression",PreferredColor=Color.Red,Color=Color.Red}
    };
    client.SendImmediate(new[]{new Order("HandshakeResponse",null,false){
        Type=OrderType.Handshake,IsImmediate=true,TargetString=handshake.Serialize()
    }});
    Wait(()=>server.Conns.Count>0&&server.Conns[0].Validated,"Server did not validate client");
    client.SendImmediate(iteration==0
        ? new[]{Order.Command("state Ready"),Order.Command("startgame")}
        : new[]{Order.Command("state Ready")});
    Wait(()=>server.State==ServerState.GameStarted,"Server did not start the selected map");
    var packets=(IEnumerable<(int FromClient,byte[] Data)>)typeof(NetworkConnection)
        .GetField("receivedPackets",BindingFlags.Instance|BindingFlags.NonPublic)!.GetValue(network)!;
    Wait(()=>packets.Any(p=>p.Data.Length>4&&p.Data[4]==(byte)OrderType.Fields&&
        OrderIO.TryParseOrderPacket(p.Data,out var orders)&&orders.Frame==0&&
        orders.Orders.GetOrders(null).Any(o=>o.OrderString=="StartGame")),
        "Client did not receive the StartGame order");
    Console.WriteLine($"PASS {(iteration==0?"skirmish":"campaign")}: real server/client handshake, server start and received StartGame order, map={maps[iteration]} ({data.MapCache[maps[iteration]].Title})");
    Game.CloseServer();
    Thread.Sleep(200);
}
Log.Dispose();
