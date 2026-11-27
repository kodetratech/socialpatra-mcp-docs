#!/bin/sh
# Builds dist/socialpatra-openai-plugin.zip from openai-plugin/ (plugin.json at the ZIP root).
# Usage: sh scripts/build-openai-plugin.sh
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
src="$root/openai-plugin"
out="$root/dist/socialpatra-openai-plugin.zip"

for f in plugin.json mcp.json assets/logo.png assets/icon.png; do
  [ -f "$src/$f" ] || { echo "missing $f" >&2; exit 1; }
done
python3 -m json.tool "$src/plugin.json" >/dev/null
python3 -m json.tool "$src/mcp.json" >/dev/null

mkdir -p "$root/dist"
rm -f "$out"
(cd "$src" && zip -X -r "$out" plugin.json mcp.json assets)
unzip -l "$out"
