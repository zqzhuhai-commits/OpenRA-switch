#!/usr/bin/env bash
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
engine_dir="${1:?Usage: build-switch-ui-hotfix.sh ENGINE_CHECKOUT ORIGINAL_RUNTIME_DLL_DIRECTORY SD_ROOT}"
runtime_dir="${2:?Pass the original managed DLL directory}"
sd_root="${3:?Pass an output SD-card root}"
engine_dir="$(cd "$engine_dir" && pwd)"
runtime_dir="$(cd "$runtime_dir" && pwd)"
dotnet_cmd="${OPENRA_DOTNET:-dotnet}"
"$repo_dir/scripts/build-managed-hotfix.sh" "$engine_dir" "$sd_root"
"$dotnet_cmd" build "$repo_dir/src/SwitchUI/OpenRA.SwitchUI.csproj" -c Release "-p:RuntimeDir=$runtime_dir" --nologo
cp "$repo_dir/src/SwitchUI/bin/Release/net9.0/OpenRA.SwitchUI.dll" "$sd_root/mono/openra/"
cecil_args=()
if [[ -n "${CECIL_DIR:-}" ]]; then cecil_args+=("-p:CecilDir=$CECIL_DIR"); fi
"$dotnet_cmd" run --project "$repo_dir/scripts/AudioTimingPatch/AudioTimingPatch.csproj" -c Release "${cecil_args[@]}" -- \
  "$runtime_dir/OpenRA.Platforms.Default.dll" "$engine_dir/bin/OpenRA.Game.dll" "$sd_root/mono/openra/OpenRA.Platforms.Default.dll"
mkdir -p "$sd_root/mono/openra/mods/ra/chrome" "$sd_root/mono/openra/mods/ra/fluent" "$sd_root/mono/openra/mods/common/fluent"
cp "$repo_dir/src/ra-mod.yaml" "$sd_root/mono/openra/mods/ra/mod.yaml"
cp "$repo_dir/assets/switch-ui/"*.yaml "$sd_root/mono/openra/mods/ra/chrome/"
cp "$repo_dir/translations/ra-fluent/rules.ftl" "$repo_dir/translations/ra-fluent/chrome.ftl" "$sd_root/mono/openra/mods/ra/fluent/"
cp "$repo_dir/translations/common-fluent/rules.ftl" "$repo_dir/translations/common-fluent/common.ftl" "$sd_root/mono/openra/mods/common/fluent/"
cp "$repo_dir/assets/mono-performance-config.ini" "$sd_root/mono/config.ini"
printf '%s\n' 'Built Switch UI/audio overlay. No user settings, maps, saves, NRO or NSP were replaced.'
