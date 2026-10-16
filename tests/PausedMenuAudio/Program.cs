using System.Reflection;
using System.Runtime.InteropServices;
using OpenRA;
using OpenRA.Network;

// Real OpenAL null output renders to no device; checks source scheduling only.
NativeLibrary.SetDllImportResolver(Assembly.Load("OpenAL-CS"), (_, _, _) => NativeLibrary.Load("libopenal.so.1"));
Log.AddChannel("sound", null);
typeof(Game).GetField("OrderManager", BindingFlags.Static|BindingFlags.NonPublic)!.SetValue(null,new OrderManager(new EchoConnection()));
var platform=Assembly.Load("OpenRA.Platforms.Default");
var type=platform.GetType("OpenRA.Platforms.Default.OpenAlSoundEngine",true)!;
using var audio=(ISoundEngine)Activator.CreateInstance(type, new object[]{null})!;
using var sample=audio.AddSoundSourceFromMemory(new byte[2205],1,8,22050);
for(int i=0;i<3;i++)
    if(audio.Play2D(sample,false,true,WPos.Zero,1f,true)==null)throw new Exception("Initial click unexpectedly suppressed");
if(audio.Play2D(sample,false,true,WPos.Zero,1f,true)!=null)throw new Exception("Burst throttle lost");
Thread.Sleep(250);
if(Game.LocalTick!=0)throw new Exception("Test requires paused simulation");
if(audio.Play2D(sample,false,true,WPos.Zero,1f,true)==null)throw new Exception("BUG: UI sound remains suppressed while the simulation is paused");
Console.WriteLine("PASS: repeated clicks are throttled within a burst and play again after 250ms with simulation frame fixed at zero.");
