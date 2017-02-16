#!/bin/bash

#inspired of: 
#   http://unix.stackexchange.com/questions/4489/a-tool-for-automatically-applying-randr-configuration-when-external-display-is-p
#   http://ozlabs.org/~jk/docs/mergefb/
#   http://superuser.com/questions/181517/how-to-execute-a-command-whenever-a-file-changes/181543#181543
export MONITOR2=/sys/class/drm/card0-HDMI-A-1/status

dmode="$(cat $MONITOR2)"
    if [ "${dmode}" = disconnected ]; then
         /usr/bin/xrandr --auto && /home/davide/audio-toggle-sink.sh 1
         echo "${dmode}"
    elif [ "${dmode}" = connected ];then
         /usr/bin/xrandr --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 1920x536 --rotate normal && /home/davide/audio-toggle-sink.sh 0
         echo "${dmode}"
    else /usr/bin/xrandr --auto && /home/davide/audio-toggle-sink.sh 1
         echo "${dmode}"
    fi
