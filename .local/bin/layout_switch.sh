#!/bin/bash
sleep 0.05
MASK=$(xset -q | grep "LED mask" | awk '{print $NF}')
FLAG=${MASK: -4:1}
if [ "$FLAG" = "1" ]; then
    LANG_CURRENT="RU"
else
    LANG_CURRENT="US"
fi
notify-send -h string:x-dunst-stack-tag:layout -t 2000 -u critical "Раскладка" "<span font_desc='Sans Bold 36'>$LANG_CURRENT</span>"