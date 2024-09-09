#!/bin/bash

active_window=$(hyprctl activewindow | grep -oP '(?<=class:\s).*')

if [[ $active_window == vesktop ]]; then
    hyprctl dispatch changegroupactive f
    hyprctl dispatch togglespecialworkspace md
else
    hyprctl dispatch togglespecialworkspace md
    hyprctl dispatch changegroupactive f
fi
