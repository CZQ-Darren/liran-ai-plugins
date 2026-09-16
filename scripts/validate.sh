#!/bin/sh
set -eu

python3 -m json.tool .agents/plugins/marketplace.json >/dev/null
python3 -m json.tool plugins/liran-bi-warehouse/.codex-plugin/plugin.json >/dev/null
python3 -m json.tool plugins/liran-bi-warehouse/.mcp.json >/dev/null
python3 -m json.tool plugins/liran-knowledge-base/.codex-plugin/plugin.json >/dev/null
python3 -m json.tool plugins/liran-knowledge-base/.mcp.json >/dev/null

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
