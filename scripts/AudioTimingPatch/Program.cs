// Patch only the source-pool throttle in the shipped platform assembly, preserving
// its otherwise unavailable controller bridge and every other platform method.
using System.Security.Cryptography;
using Mono.Cecil;
using Mono.Cecil.Cil;
using Mono.Cecil.Rocks;

if (args.Length != 3) throw new ArgumentException("INPUT_PLATFORM_DLL ENGINE_DLL OUTPUT_PLATFORM_DLL");
var expected = "d35fdd5cd1d40046c4c278eed19da23329ad6ec146d5b7b8a83cc7eea458fe6f";
if (Convert.ToHexString(SHA256.HashData(File.ReadAllBytes(args[0]))).ToLowerInvariant() != expected)
    throw new InvalidDataException("Platform DLL differs from the audited original Switch package; refusing to patch.");
using var platform = AssemblyDefinition.ReadAssembly(args[0]);
using var engine = AssemblyDefinition.ReadAssembly(args[1]);
var runTime = engine.MainModule.GetType("OpenRA.Game").Methods.Single(m => m.Name == "get_RunTime");
var type = platform.MainModule.GetType("OpenRA.Platforms.Default.OpenAlSoundEngine");
int calls = 0, thresholds = 0;
foreach (var name in new[] { "Play2D", "Play2DStream" })
{
    var method = type.Methods.Single(m => m.Name == name);
    method.Body.SimplifyMacros();
    foreach (var instruction in method.Body.Instructions.ToArray())
    {
        if (instruction.OpCode == OpCodes.Call && instruction.Operand is MethodReference r && r.FullName == "System.Int32 OpenRA.Game::get_LocalTick()")
        {
            instruction.Operand = platform.MainModule.ImportReference(runTime);
            method.Body.GetILProcessor().InsertAfter(instruction, Instruction.Create(OpCodes.Conv_I4));
            calls++;
        }
        if (name == "Play2D" && instruction.OpCode == OpCodes.Ldc_I4 && (int)instruction.Operand == 5 && instruction.Previous.OpCode == OpCodes.Sub)
        {
            instruction.Operand = 200; // 5 normal simulation ticks = 200ms, even with the shellmap paused.
            thresholds++;
        }
    }
    method.Body.OptimizeMacros();
}
if (calls != 2 || thresholds != 1) throw new InvalidDataException($"Unexpected IL: calls={calls}, thresholds={thresholds}");
platform.Write(args[2]);
Console.WriteLine("PASS: changed only Play2D/Play2DStream throttle to wall-clock milliseconds; original controller and rendering implementations preserved.");
