#!/bin/sh
set -eu

python3 -m json.tool .agents/plugins/marketplace.json >/dev/null
python3 -m json.tool plugins/liran-bi-warehouse/.codex-plugin/plugin.json >/dev/null
python3 -m json.tool plugins/liran-bi-warehouse/.mcp.json >/dev/null
python3 -m json.tool plugins/liran-knowledge-base/.codex-plugin/plugin.json >/dev/null
python3 -m json.tool plugins/liran-knowledge-base/.mcp.json >/dev/null

python3 - <<'PY'
import json
from pathlib import Path

marketplace = json.loads(Path('.agents/plugins/marketplace.json').read_text())
assert marketplace['interface']['displayName'] == '理然AI插件'

for plugin_dir in ('liran-bi-warehouse', 'liran-knowledge-base'):
    manifest_path = Path('plugins') / plugin_dir / '.codex-plugin' / 'plugin.json'
    manifest = json.loads(manifest_path.read_text())
    interface = manifest['interface']
    assert interface['composerIcon'] == './assets/icon.png'
    assert interface['logo'] == './assets/icon.png'
    assert (Path('plugins') / plugin_dir / 'assets' / 'icon.png').is_file()
PY

for skill in \
  plugins/liran-bi-warehouse/skills/liran-bi-warehouse/SKILL.md \
  plugins/liran-knowledge-base/skills/liran-knowledge-base/SKILL.md
do
  test -s "$skill"
  head -n 1 "$skill" | grep -qx -- '---'
  grep -q '^name: ' "$skill"
  grep -q '^description: ' "$skill"
done

echo "Marketplace manifests and skills look valid."
