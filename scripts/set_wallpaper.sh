#!/run/current-system/sw/bin/bash

CURR=$(hyprctl hyprpaper listloaded)
hyprctl hyprpaper preload "$1"
hyprctl hyprpaper wallpaper "DP-1,$1"
hyprctl hyprpaper unload "$CURR"

