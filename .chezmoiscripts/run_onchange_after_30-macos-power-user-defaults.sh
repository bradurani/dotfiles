#!/bin/sh
# macOS power-user defaults. Runs on `chezmoi apply` whenever this file changes.
# Finder / .DS_Store settings live in run_once_after_20-macos-open-save-dialogs.sh.
set -eu

[ "$(uname -s)" = "Darwin" ] || exit 0

# --- Keyboard & typing -------------------------------------------------------
# Fast key repeat; holding a key repeats it instead of showing the accent popup.
# Takes effect after logging out and back in.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# No smart quotes / dashes (they corrupt pasted code and config).
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Tab moves focus between all controls (dialog buttons included).
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# --- Trackpad ----------------------------------------------------------------
# Three-finger drag (built-in and Bluetooth trackpads). Applies after logout.
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# --- Dock --------------------------------------------------------------------
# Auto-hide with no delay and a quick animation.
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# --- Screenshots -------------------------------------------------------------
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

# Deliberately not automated (do these by hand):
# - Touch ID for sudo: security setting that needs sudo. Run:
#     sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
#   then uncomment the pam_tid.so line in /etc/pam.d/sudo_local.
# - Caps Lock remap: System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys.
#   (A hidutil mapping here would clash with ~/.local/bin/key.)
# - Hot Corners: System Settings > Desktop & Dock > Hot Corners.
