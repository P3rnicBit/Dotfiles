#!/bin/bash

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

CONFIG_DIRS=(
  hypr
  kitty
  nvim
  scripts
  waybar
  wofi
  mpd
  ncmpcpp
  firejail
)

link() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ]; then
    echo "already linked: $dst, skipping"
  elif [ -e "$dst" ]; then
    echo "file exists: $dst, skipping (remove manually to replace)"
  else
    ln -s "$src" "$dst"
    echo "linked: $dst"
  fi
}

for dir in "${CONFIG_DIRS[@]}"; do
  link "$DOTFILES/$dir" "$HOME/.config/$dir"
done

link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
