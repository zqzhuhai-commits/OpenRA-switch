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


var campaigns = data.MapCache.Where(m => m.Status == MapStatus.Available && m.Visibility.HasFlag(MapVisibility.MissionSelector)).ToArray();
int briefs=0, previews=0, missingMedia=0, missingRequired=0;
var videos = new SortedSet<string>();
foreach (var map in campaigns)
{
    var mission=map.WorldActorInfo.TraitInfoOrDefault<OpenRA.Mods.Common.Traits.MissionDataInfo>();
    var lua=map.WorldActorInfo.TraitInfoOrDefault<OpenRA.Mods.Common.Scripting.LuaScriptInfo>();
    if(lua!=null) foreach(var script in lua.Scripts)
        if(!((OpenRA.FileSystem.IReadOnlyFileSystem)map).Exists(script)){Console.WriteLine("MISSING_SCRIPT " + map.Title + "/" + script);missingRequired++;}
    if (mission == null) { Console.WriteLine("NO_MISSION_DATA " + map.Title); missingRequired++; continue; }
    if (map.TryGetMessage(mission.Briefing, out var brief) && !string.IsNullOrWhiteSpace(brief)) briefs++;
    else {Console.WriteLine("NO_BRIEFING " + map.Title);missingRequired++;}
    if(File.Exists(Path.Combine(map.Path,"map.png"))) { using var image=File.OpenRead(Path.Combine(map.Path,"map.png")); _ = new OpenRA.FileFormats.Png(image); previews++; }
    else {Console.WriteLine("NO_PREVIEW " + map.Title);missingRequired++;}
    foreach(var name in new[]{"map.yaml","map.bin"})
        if(!File.Exists(Path.Combine(map.Path,name))) {Console.WriteLine("MISSING_REQUIRED " + map.Title + "/" + name);missingRequired++;}
    foreach(var name in new[]{mission.BackgroundVideo,mission.BriefingVideo,mission.StartVideo,mission.WinVideo,mission.LossVideo})
        if(!string.IsNullOrEmpty(name))videos.Add(name);
}
foreach(var video in videos)
    if(!data.DefaultFileSystem.Exists(video)){missingMedia++;Console.WriteLine("MISSING_OPTIONAL_VIDEO " + video);}
Console.WriteLine($"Campaigns={campaigns.Length}; briefings={briefs}; previews={previews}; requiredFailures={missingRequired}; optionalVideosMissing={missingMedia}/{videos.Count}");
if(missingRequired!=0) Environment.ExitCode=1;
var music=data.DefaultRules.Music.Values.ToArray();
foreach(var m in music.Where(m=>data.DefaultFileSystem.Exists(m.Filename)))Console.WriteLine("MUSIC_PRESENT " + m.Filename + "; hidden=" + m.Hidden);
Console.WriteLine($"MusicFilesPresent={music.Count(m=>data.DefaultFileSystem.Exists(m.Filename))}/{music.Length}");
Log.Dispose();
