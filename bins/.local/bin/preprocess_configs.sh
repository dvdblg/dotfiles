#!/bin/bash

xrdb -load  "$HOME/.config/xresources/config"
xrdb -merge "$HOME/.config/xresources/themes/$(cat "$HOME/.theme")"

INFILES=$(tr '\n' ' ' <<-ENDINFILES
  $HOME/.config/herbstluftwm/config
  $HOME/.config/polybar/config
  $HOME/.config/polybar/scripts/info-hlwm-workspaces.sh
  $HOME/.config/dunst/dunstrc
  $HOME/.config/rofi/xresources
  $HOME/.local/share/sddm/themes/Xresources/Main.qml
  $HOME/.config/termite/config
  $HOME/.config/bspwm/bspwmrc
  $HOME/.config/zathura/zathurarc
  $HOME/.config/kitty/kitty.conf
  $HOME/.config/alacritty/alacritty.yml
  $HOME/.mozilla/firefox/trktth22.default-release/chrome/userChrome.css
  $HOME/.config/wpg/schemes/_home_davide__config_wpg_wallpapers_mountain-sunset_jpg_dark_wal__1.1.0.json
  $HOME/.local/share/color-schemes/Xresources.colors
ENDINFILES
)
for file in $INFILES; do
  preprocess "$file" &
done && wait


