#!/bin/bash
performance=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [[ $performance = 1 ]]; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:active_opacity 1;\
        keyword decoration:inactive_opacity 1;\
        keyword decoration:rounding 0"
else
    hyprctl reload
fi

