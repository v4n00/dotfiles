#!/bin/bash

volume_step=2
brightness_step=12
max_volume=100
notification_timeout=1000

function get_volume {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'
}

function get_mute {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if ($3 == "[MUTED]") print "yes"; else print "no"}'
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
    get_volume_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume "$volume_icon  $volume%"
}

function show_brightness_notif {
    get_brightness_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "$brightness_icon  $brightness%"
}

case $1 in
    volume_up)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    volume=$(get_volume)
    if [ $(( "$volume" + "$volume_step" )) -gt $max_volume ]; then
	wpctl set-volume @DEFAULT_AUDIO_SINK@ $max_volume%
    else
	wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume_step%+
    fi
    show_volume_notif
    ;;

    volume_down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume_step%-
    volume=$(get_volume)
    if [ "$volume" -le 0 ]; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    fi
    show_volume_notif
    ;;

    volume_mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
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

