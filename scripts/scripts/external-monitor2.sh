#!/bin/bash

#SCREEN_LEFT=DP2
#SCREEN_RIGHT=eDP1
START_DELAY=5

renice +19 $$ >/dev/null

sleep $START_DELAY

OLD_DUAL="dummy"

while [ 1 ]; do
    DUAL=$(cat /sys/class/drm/card0-HDMI-A-1/status)

    if [ "$OLD_DUAL" != "$DUAL" ]; then
        if [ "$DUAL" == "connected" ]; then
            echo 'Dual monitor setup'
            /usr/bin/xrandr --output HDMI1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output eDP1 --mode 1366x768 --pos 0x544 --rotate normal --output VGA1 --off && /home/davide/audio-toggle-sink.sh 0
        else
            echo 'Single monitor setup'
            /usr/bin/xrandr --auto && /home/davide/audio-toggle-sink.sh 1
        fi

        OLD_DUAL="$DUAL"
    fi

    inotifywait -q -e close /sys/class/drm/card0-DP-2/status >/dev/null
done

