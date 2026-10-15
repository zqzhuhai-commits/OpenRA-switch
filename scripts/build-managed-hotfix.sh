#!/usr/bin/env bash
# Build the managed-only single-player fix against the original release baseline.
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
engine_dir="${1:?Usage: build-managed-hotfix.sh /path/to/OpenRA-playtest-20260222 [/path/to/SD-root]}"
engine_dir="$(cd "$engine_dir" && pwd)"
expected_sha=5c51f458f2e9f8ec4921eea8d07823c8358680f8
if [[ "$(git -C "$engine_dir" rev-parse HEAD)" != "$expected_sha" ]]; then
  echo 'Expected upstream OpenRA playtest-20260222. Use a separate checkout.' >&2
  exit 1
fi
python3 - "$repo_dir" "$engine_dir" <<'PY'
import sys
from pathlib import Path
repo,engine=map(Path,sys.argv[1:])
mapping={
 'Game.cs':'OpenRA.Game/Game.cs',
 'AssemblyLoader.cs':'OpenRA.Game/Support/AssemblyLoader.cs',
 'DebugAssertionSuppressor.cs':'OpenRA.Game/Support/DebugAssertionSuppressor.cs',
 'Settings.cs':'OpenRA.Game/Settings.cs',
 'MapDirectoryTracker.cs':'OpenRA.Game/Map/MapDirectoryTracker.cs',
 'Platform.cs':'OpenRA.Game/Platform.cs',
 'Network-Connection.cs':'OpenRA.Game/Network/Connection.cs',
 'Server-Connection.cs':'OpenRA.Game/Server/Connection.cs',
 'Server.cs':'OpenRA.Game/Server/Server.cs',
 'ConnectionTarget.cs':'OpenRA.Game/Network/ConnectionTarget.cs',
 'LocalTransport.cs':'OpenRA.Game/Network/LocalTransport.cs',
}
for source,dest in mapping.items():
 (engine/dest).write_bytes((repo/'src'/source).read_bytes())
p=engine/'Directory.Build.props';s=p.read_text()
s=s.replace('<TargetFramework>net8.0</TargetFramework>','<TargetFramework>net9.0</TargetFramework>')
if '<TargetFramework>net9.0</TargetFramework>' not in s:raise SystemExit('Expected .NET 9 build target')
marker='<!-- OpenRA Switch managed hotfix -->'
if marker not in s:
 s=s.replace('</Project>',marker+'\n<PropertyGroup><DefineConstants>$(DefineConstants);TRACE;SWITCH</DefineConstants><UseAppHost>false</UseAppHost></PropertyGroup>\n</Project>')
p.write_text(s)
PY
"${OPENRA_DOTNET:-dotnet}" build "$engine_dir/OpenRA.Game/OpenRA.Game.csproj" -c Release --nologo -m:1
if [[ -n "${2:-}" ]]; then
  mkdir -p "$2/mono/openra"
  cp "$engine_dir/bin/OpenRA.Game.dll" "$2/mono/openra/"
fi
printf '%s\n' 'Built OpenRA.Game.dll. Existing NRO, runtime, maps, translations and saves are retained.'
