#!/bin/bash

volume_step=2
brightness_step=12
max_volume=100
notification_timeout=1000

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

function get_brightness {
    echo $(($(brightnessctl g) / 4))
}

function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ]; then
        volume_icon=""
    elif [ "$volume" -lt 50 ]; then
        volume_icon=""
    else
        volume_icon=""
    fi
}

function get_brightness_icon {
    brightness=$(get_brightness)
    step=$((brightness / 12))
    case $step in
	0) 
        brightness_icon=""
	;;

        1)
        brightness_icon=""
        ;;

        2)
        brightness_icon=""
        ;;

        3)
        brightness_icon=""
        ;;

        4)
        brightness_icon=""
        ;;

        5)
        brightness_icon=""
        ;;

        6)
        brightness_icon=""
        ;;
    
        7)
        brightness_icon=""
        ;;
    
        8)
        brightness_icon=""
        ;;
    esac    
}

function show_volume_notif {
    volume=$(get_mute)
    get_volume_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume "$volume_icon  $volume%"
}

function show_brightness_notif {
    brightness=$(get_brightness)
    get_brightness_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "$brightness_icon  $brightness%"
}

case $1 in
    volume_up)
    pactl set-sink-mute @DEFAULT_SINK@ 0
    volume=$(get_volume)
    if [ $(( "$volume" + "$volume_step" )) -gt $max_volume ]; then
        pactl set-sink-volume @DEFAULT_SINK@ $max_volume%
    else
        pactl set-sink-volume @DEFAULT_SINK@ +$volume_step%
    fi
    show_volume_notif
    ;;

    volume_down)
    pactl set-sink-volume @DEFAULT_SINK@ -$volume_step%
    volume=$(get_volume)
    if [ "$volume" -le 0 ]; then
	pactl set-sink-mute @DEFAULT_SINK@ 1
    fi
    show_volume_notif
    ;;

    volume_mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_volume_notif
    ;;

    brightness_up)
    brightnessctl set $brightness_step+
    show_brightness_notif
    ;;

    brightness_down)
    brightness=$(get_brightness)
    if [ $((brightness * 4 - brightness_step)) -le $brightness_step ]; then
	brightnessctl set $min_brightness 
    else
	brightnessctl set $brightness_step-
    fi
    show_brightness_notif
    ;;
esac

