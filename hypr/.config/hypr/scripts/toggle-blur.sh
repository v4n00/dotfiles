#!/bin/bash
opacity=$(hyprctl getoption decoration:active_opacity | awk '/float/ {if ($2 == 1.0) print 1}')
if [[ $opacity != 1 ]]; then
    hyprctl --batch "\
	keyword decoration:active_opacity 1;\
	keyword decoration:inactive_opacity 1;"
else
    hyprctl reload
fi
