using OpenRA;
using OpenRA.FileSystem;

var package=new Package();
using(var tracker=new MapDirectoryTracker(package,MapClassification.System))
{
    tracker.UpdateMaps(new MapCache());
    tracker.Dispose(); // shutdown must also tolerate a missing watcher
}
if(System.IO.FileSystemWatcher.Creations!=0)throw new Exception("Switch startup called the unavailable watcher API");
Console.WriteLine("PASS: Switch tracker startup/update/dispose when FileSystemWatcher always throws PlatformNotSupportedException.");

sealed class Package:IReadOnlyPackage { public string Name=>"/nonexistent/switch/map-directory"; }
namespace OpenRA.FileSystem { public interface IReadOnlyPackage { string Name {get;} } }
namespace OpenRA
{
    public enum MapClassification { System }
    public enum MapStatus { Available }
    public sealed class MapPreview
    {
        public string Path,Uid;
        public MapStatus Status;
        public void Invalidate(){}
    }
    public sealed class MapCache:List<MapPreview>
    {
        public void LoadMap(string path,IReadOnlyPackage package,MapClassification classification,string uid){}
    }
}
namespace System.IO
{
    // Fault-injection stand-in for the unsupported mono-nx API, not a production shim.
    public sealed class FileSystemWatcher:IDisposable
    {
        public static int Creations;
        public FileSystemWatcher(string path)
        {
            Creations++;
            throw new PlatformNotSupportedException("System.IO.FileSystem.Watcher is not supported on this platform.");
        }
        public event FileSystemEventHandler Changed,Created,Deleted;
        public event RenamedEventHandler Renamed;
        public bool IncludeSubdirectories {get;set;}
        public bool EnableRaisingEvents {get;set;}
        public void Dispose(){}
    }
}
