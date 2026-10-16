using System.Reflection;
using System.Runtime.CompilerServices;
using System.Linq.Expressions;
using OpenRA.Graphics;
using OpenRA.Widgets;
using OpenRA.Mods.Common.Widgets;
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
data.MapCache.LoadPreviewImages=true;
data.MapCache.LoadMaps(data);


Game.LocalPlayerProfile = new LocalPlayerProfile(Path.Combine(Platform.SupportDir,"test-no-keys"),data.GetOrCreate<PlayerDatabase>());
var renderer=(Renderer)RuntimeHelpers.GetUninitializedObject(typeof(Renderer));
var window=DispatchProxy.Create<IPlatformWindow, WindowStub>();
typeof(Renderer).GetField("<Window>k__BackingField",BindingFlags.Instance|BindingFlags.NonPublic)!.SetValue(renderer,window);
var font=(SpriteFont)RuntimeHelpers.GetUninitializedObject(typeof(SpriteFont));
var glyphType=typeof(SpriteFont).Assembly.GetType("OpenRA.Graphics.GlyphInfo")!;
var glyph=RuntimeHelpers.GetUninitializedObject(glyphType);
glyphType.GetField("Advance")!.SetValue(glyph,8f);
var callback=Expression.Lambda(typeof(Func<,>).MakeGenericType(typeof(char),glyphType),Expression.Constant(glyph,glyphType),Expression.Parameter(typeof(char))).Compile();
var cache=Activator.CreateInstance(typeof(Cache<,>).MakeGenericType(typeof(char),glyphType),callback)!;
foreach(var (name,value) in new (string,object)[]{("size",18),("deviceScale",1f),("glyphs",cache)})
    typeof(SpriteFont).GetField(name,BindingFlags.Instance|BindingFlags.NonPublic)!.SetValue(font,value);
renderer.Fonts=data.GetOrCreate<Fonts>().FontList.Keys.ToDictionary(k=>k,_=>font);
Game.Renderer=renderer;
ChromeMetrics.Initialize(data);
var sprite=(Sprite)RuntimeHelpers.GetUninitializedObject(typeof(Sprite));
typeof(ChromeProvider).GetField("cachedSprites",BindingFlags.Static|BindingFlags.NonPublic)!.SetValue(null,new Dictionary<string,Dictionary<string,Sprite>>{
    {"lobby-bits",new Dictionary<string,Sprite>{{"spawn-claimed",sprite},{"spawn-unclaimed",sprite},{"spawn-disabled",sprite}}}
});
Ui.Initialize(data);
Ui.Root.Bounds=new WidgetBounds(0,0,1280,720);
var browser=Ui.OpenWindow("MISSIONBROWSER_PANEL",new WidgetArgs{
    {"world",null}, {"onStart",(Action)(()=>{})}, {"onExit",(Action)(()=>{})},
    {"initialMap","b2ce921eb06ff3529d81a3755f75777240068a35"}
});
var description=browser.Get<LabelWidget>("MISSION_DESCRIPTION");
if(string.IsNullOrWhiteSpace(description.GetText()) || description.GetText().Length<30)throw new Exception("Mission briefing blank");
if(!description.IsVisible())throw new Exception("Mission briefing hidden");
var preview=browser.Get<MapPreviewWidget>("MISSION_PREVIEW");
if(preview.Preview()==null || preview.Preview().Preview==null)throw new Exception("Mission preview missing");
var start=browser.Get<ButtonWidget>("STARTGAME_BUTTON");
if(start.IsDisabled())throw new Exception("Mission start button disabled");
start.OnClick();
if(!start.IsDisabled())throw new Exception("Repeated launch not prevented");
var server=(Server)typeof(Game).GetField("server",BindingFlags.Static|BindingFlags.NonPublic)!.GetValue(null)!;
start.OnClick();
if(!ReferenceEquals(server,typeof(Game).GetField("server",BindingFlags.Static|BindingFlags.NonPublic)!.GetValue(null)))throw new Exception("Double click replaced server");
var om=(OrderManager)typeof(Game).GetField("OrderManager",BindingFlags.Static|BindingFlags.NonPublic)!.GetValue(null)!;
var timer=System.Diagnostics.Stopwatch.StartNew();
while(server.State!=ServerState.GameStarted && timer.ElapsedMilliseconds<20000){om.TickImmediate();Thread.Sleep(20);}
if(server.State!=ServerState.GameStarted)throw new Exception("Mission UI did not start server");
var scaling=data.ObjectCreator.FindType("SwitchDisplaySettingsLogic")!;
var scales=(IEnumerable<float>)scaling.GetMethod("ValidUIScales")!.Invoke(null,new object[]{new Size(1280,720),new Size(1024,720)})!;
if(!scales.SequenceEqual(new[]{0.75f,0.8f,0.9f,1f}))throw new Exception("Unsafe 720p scale options");
var defaults=new GraphicSettings();
if(defaults.UIScale!=1f || !defaults.CapFramerate || defaults.MaxFramerate!=30 || defaults.CapFramerateToGameFps)throw new Exception("Switch frame/UI defaults mismatch");
Console.WriteLine("PASS: 720p scale options 75/80/90/100%; default frame cap 30fps and UI scale 100%.");
Console.WriteLine("PASS: actual mission widget loads its briefing and selected preview; Start button invokes real local handshake and starts campaign server; repeated clicks are guarded. Font metrics and window size are test substitutes; no GPU/Lua gameplay test.");
om.Dispose();Game.CloseServer();Log.Dispose();

public class WindowStub : DispatchProxy
{
    protected override object Invoke(MethodInfo method, object[] args)
    {
        var t=method!.ReturnType;
        if(t==typeof(Size))return new Size(1280,720);
        if(t==typeof(float))return 1f;
        if(t==typeof(int))return 1;
        if(t==typeof(bool))return true;
        if(t==typeof(void))return null;
        if(t==typeof(GLProfile[]))return new[]{GLProfile.Embedded};
        return t.IsValueType?Activator.CreateInstance(t):null;
    }
}
