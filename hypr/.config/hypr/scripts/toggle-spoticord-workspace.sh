#!/bin/bash

active_window=$(hyprctl activewindow | grep -oP '(?<=class:\s).*')

if [[ $active_window == Spotify ]]; then
    hyprctl dispatch togglespecialworkspace spoticord
else
    if [[ $active_window == vesktop ]]; then
	hyprctl dispatch focuswindow class:Spotify
        hyprctl dispatch togglespecialworkspace spoticord
    else
	hyprctl dispatch togglespecialworkspace spoticord
	hyprctl dispatch focuswindow class:vesktop
    fi
fi
