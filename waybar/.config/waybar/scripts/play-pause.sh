#!/bin/bash

status=$(playerctl --player=cmus metadata --format='{{ status }}')
title=$(playerctl --player=cmus metadata --format='{{ title }}')

if [[ $status != "" ]]; then
    if [[ $status == "Playing" ]]; then
	    icon=""
    else
	    icon=""
    fi
    echo "$title $icon"
fi
