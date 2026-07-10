#!/usr/bin/env bash
# SessionStart hook: keep the installed status line script in step with the one
# shipped in this plugin, so a fix ships to students on their next session
# rather than waiting for them to re-run quickstart.
#
# settings.json can't point into the plugin directly (its path is content-hashed
# and changes on every update), and a plugin's bundled settings.json cannot set
# `statusLine` at all --- so the script has to live at a stable path, and
# something has to keep that copy current. This is that something.
#
# It is a no-op until the student opts in: quickstart creates the directory and
# writes settings.json. A status line script materialising in ~/.claude for
# someone who never asked for one would be a surprise.

set -uo pipefail

src="${CLAUDE_PLUGIN_ROOT:-}/scripts/statusline.sh"
dest="$HOME/.claude/comp4020/statusline.sh"

[[ -f "$src" ]] || exit 0
[[ -d "${dest%/*}" ]] || exit 0 # not opted in

cmp -s "$src" "$dest" 2>/dev/null || {
  cp "$src" "$dest" 2>/dev/null && chmod +x "$dest" 2>/dev/null
}

# SessionStart hook stdout is injected into the session context. Say nothing.
exit 0
