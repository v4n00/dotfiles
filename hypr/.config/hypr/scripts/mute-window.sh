#!/bin/bash

ACTIVE_PID=$(hyprctl activewindow | grep -oP 'pid: \K\d+')

SINKS=$(pactl list sink-inputs | awk -v pid="$ACTIVE_PID" '
/Sink Input/ {id=$3; sub(/^#/, "", id); mute=""; next}
/Mute:/ {mute=$2}
/application.process.id/ && $0 ~ pid {print id "," mute}')

if [ -z "$SINKS" ]; then
    APP_NAME=$(ps -p $ACTIVE_PID -o comm=)
    SINKS=$(pactl list sink-inputs | awk -v app="$APP_NAME" '
/Sink Input/ {id=$3; sub(/^#/, "", id); mute=""; next}
/Mute:/ {mute=$2}
/application.name/ && tolower($0) ~ tolower(app) {print id "," mute}
')
fi

for sink in $SINKS; do
    ID=$(echo "$sink" | cut -d',' -f1)
    STATUS=$(echo "$sink" | cut -d',' -f2)

    if [ "$STATUS" = "yes" ]; then
        pactl set-sink-input-mute $ID 0
    else
        pactl set-sink-input-mute $ID 1
    fi
done
