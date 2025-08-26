#!/bin/bash

volume_step=2
max_volume=100

notification_timeout=1000
assets=~/.config/hypr/scripts/assets

function get_volume {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'
}

function get_mute {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if ($3 == "[MUTED]") print "yes"; else print "no"}'
}

function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ]; then
        volume_icon=$assets/volume-mute.svg
    elif [ "$volume" -lt 50 ]; then
        volume_icon=$assets/volume-low.svg
    else
        volume_icon=$assets/volume-high.svg
    fi
}

function show_volume_notif {
    get_volume_icon
    notify-send -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume -i "$volume_icon" "Volume" "Volume currently at $volume%"
}

case $1 in
volume_up)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    volume=$(get_volume)
    if [ $(("$volume" + "$volume_step")) -gt $max_volume ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $max_volume%
    else
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume_step%+
    fi
    show_volume_notif
    ;;

volume_down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $volume_step%-
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -le 0 ] && [ "$mute" == "no" ]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    fi
    show_volume_notif
    ;;

volume_mute)
    volume=$(get_volume)
    if [ "$volume" -ne 0 ]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    fi
    show_volume_notif
    ;;
esac

