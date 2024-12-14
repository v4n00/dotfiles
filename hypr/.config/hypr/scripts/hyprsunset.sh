#!/bin/bash
kelvin_values=(0 2700 2200 1800 1200)
state_file="/tmp/hyprsunset_state"
notification_timeout=1000
assets=~/.config/hypr/scripts/assets

if [[ -f $state_file ]]; then
    current_index=$(cat $state_file)
else
    current_index=0
fi

kelvin=${kelvin_values[$current_index]}
icon=$assets/brightness-$((current_index * 2)).svg
pkill -x hyprsunset

send_notification() {
    notify-send -h string:x-dunst-stack-tag:hyprsunset -i "$icon" "Hyprsunset" "$1"
}

if [[ $kelvin -ne 0 ]]; then
    hyprsunset -t $kelvin &
    send_notification "Set to ${kelvin}K"
else
    send_notification "Turned off"
fi

echo $(( (current_index + 1) % ${#kelvin_values[@]} )) > $state_file
