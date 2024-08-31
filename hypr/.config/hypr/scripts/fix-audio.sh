#!/bin/bash

pactl set-sink-mute @DEFAULT_SINK@ 1
pactl set-sink-mute @DEFAULT_SINK@ 0
pactl set-source-mute @DEFAULT_SOURCE@ 1
pactl set-source-mute @DEFAULT_SOURCE@ 0
