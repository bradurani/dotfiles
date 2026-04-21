#!/bin/sh
set -eu
CHEZMOI_SOURCE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
if command -v brew >/dev/null 2>&1 && [ -f "$CHEZMOI_SOURCE_DIR/Brewfile" ]; then
  brew bundle --file="$CHEZMOI_SOURCE_DIR/Brewfile"
fi
