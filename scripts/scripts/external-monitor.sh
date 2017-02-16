#!/bin/bash


export MONITOR2=/sys/class/drm/card0-HDMI-A-1/status

while xrandroutputchangewait;

dmode="$(cat $MONITOR2)"

do
    if [ "${dmode}" = disconnected ]; then
         /usr/bin/xrandr --auto && /home/davide/audio-toggle-sink.sh 1
         echo "${dmode}"
    elif [ "${dmode}" = connected ];then
         xrandr  --output HDMI-1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output eDP-1 --mode 1366x768 --pos 0x0 --rotate normal
    /home/davide/audio-toggle-sink.sh 0 && killall compton && compton -b
         echo "${dmode}"
    else /usr/bin/xrandr --auto && /home/davide/audio-toggle-sink.sh 1 && killall compton && compton -b
         echo "${dmode}"
    fi
done
