#!/bin/bash
cliphist list | tofi --prompt-text "clip: " "$@" | cliphist decode | wl-copy

