#!/bin/bash

status=$(playerctl --player=spotify metadata --format='{{ status }}')
title=$(playerctl --player=spotify metadata --format='{{ title }}')

if [[ $status != "" ]]; then
    if [[ $status == "Playing" ]]; then
	icon=""
    else
	icon=""
    fi
    echo "$title $icon"
fi
