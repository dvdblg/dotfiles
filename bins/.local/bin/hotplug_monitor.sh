#!/bin/bash

######################################
## /usr/local/bin/hotplug_monitor.sh
######################################
echo "enter"
X_USER=davide
export DISPLAY=:0
export XAUTHORITY=/home/$X_USER/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

function connect()
{   
    #connect HDMI-1
echo "inside connect()"
    xrandr --output HDMI-1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output eDP-1 --mode 1366x768 --pos 0x0 --rotate normal
    /home/davide/audio-toggle-sink.sh 0
}

function disconnect(){
echo "inside disconnect()"
    /usr/bin/xrandr --auto
    /home/davide/audio-toggle-sink.sh 1
    
}

if [ $(cat /sys/class/drm/card0-HDMI-A-1/status) == "connected" ] ; then
  connect
elif [ $(cat /sys/class/drm/card0-HDMI-A-1/status) == "disconnected" ] ; then
  disconnect
else 
  exit
fi
echo "exit"
