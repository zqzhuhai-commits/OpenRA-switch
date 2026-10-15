#!/bin/bash
# OpenRA Switch 构建脚本（在 switch-port/openra-src 下执行）
set -e
SRC_DIR="$(cd "$(dirname "$0")/../switch-port/openra-src" && pwd)"
PKG_DIR="$(cd "$(dirname "$0")/../switch-port/pkg" && pwd)"
DOTNET9="$(cd "$(dirname "$0")/../switch-port/dotnet9" && pwd)"

export PATH="$DOTNET9:$PATH"
export DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1

cd "$SRC_DIR"
echo "==> 编译（TRACE;SWITCH, Release）"
dotnet build -c Release '-p:DefineConstants=TRACE;SWITCH'

echo "==> 拷贝 dll 到 pkg/mono/openra"
for f in OpenRA.Game.dll OpenRA.Utility.dll OpenRA.dll OpenRA.Platforms.Default.dll \
         OpenRA.Mods.Common.dll OpenRA.Mods.Cnc.dll OpenRA.Mods.D2k.dll OpenRA.Server.dll; do
  cp "bin/$f" "$PKG_DIR/mono/openra/"
done

echo "==> check-yaml"
cp "$SRC_DIR/bin/OpenRA.Utility.runtimeconfig.json" "$PKG_DIR/mono/openra/"
(cd "$PKG_DIR/mono/openra" && HOME=/tmp timeout 300 "$DOTNET9/dotnet" OpenRA.Utility.dll ra --check-yaml)
rm -f "$PKG_DIR/mono/openra/OpenRA.Utility.runtimeconfig.json"

echo "==> 打包"
rm -rf "$PKG_DIR/mono/openra/Support/Logs"
cd "$(dirname "$PKG_DIR")"
rm -f ../OpenRA-Switch-Atmosphere.zip
zip -q -r ../OpenRA-Switch-Atmosphere.zip pkg/ -x '*.DS_Store'
echo "完成: ../OpenRA-Switch-Atmosphere.zip"
