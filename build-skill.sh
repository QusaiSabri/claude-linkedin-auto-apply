#!/bin/sh
# Rebuilds linkedin-auto-apply.skill from SKILL.md and references/.
# Run after editing any of those files so the package never ships without references/.
set -e
cd "$(dirname "$0")"
stage="$(mktemp -d)"
mkdir -p "$stage/linkedin-auto-apply/references"
cp SKILL.md "$stage/linkedin-auto-apply/"
cp references/*.md "$stage/linkedin-auto-apply/references/"
rm -f linkedin-auto-apply.skill
(cd "$stage" && zip -0 -r -X -q "$OLDPWD/linkedin-auto-apply.skill" linkedin-auto-apply)
rm -rf "$stage"
unzip -l linkedin-auto-apply.skill
