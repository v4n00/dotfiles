#!/bin/bash

active_window=$(hyprctl activewindow | grep -oP '(?<=class:\s).*')
kitty_pid=$(hyprctl clients | awk '/workspace: -[0-9]+ \(special:md\)/,/pid:/ { if ($0 ~ /class: kitty/) { found_kitty=1 } if ($0 ~ /pid:/ && found_kitty) { print $NF; found_kitty=0 } }')

if [[ $active_window == vesktop ]]; then
    hyprctl dispatch focuswindow pid:$kitty_pid
    hyprctl dispatch togglespecialworkspace md
else
    hyprctl dispatch togglespecialworkspace md
    hyprctl dispatch focuswindow class:vesktop
fi
