#!/bin/bash

#Adapt this script to your needs.

DEVICES=$(find /sys/class/drm/*/status)

#inspired by /etc/acpd/lid.sh and the function it sources

displaynum=`ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##`
display=":$displaynum.0"
export DISPLAY=":$displaynum.0"

uid=$(ck-list-sessions | awk 'BEGIN { unix_user = ""; } /^Session/ { unix_user = ""; } /unix-user =/ { gsub(/'\''/,"",$3); unix_user = $3; } /x11-display = '\'$display\''/ { print unix_user; exit (0); }')
if [ -n "$uid" ]; then
	# from https://wiki.archlinux.org/index.php/Acpid#Laptop_Monitor_Power_Off
	export XAUTHORITY=$(ps -C Xorg -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')
else
  echo "unable to find an X session"
  exit 1
fi


#this while loop declare the $HDMI1 $VGA1 $LVDS1 and others if they are plugged in
while read l 
do 
  dir=$(dirname $l); 
  status=$(cat $l); 
  dev=$(echo $dir | cut -d\- -f 2-); 
  
  if [ $(expr match  $dev "HDMI") != "0" ]
  then
#REMOVE THE -X- part from HDMI-X-n
    dev=HDMI${dev#HDMI-?-}
  else 
    dev=$(echo $dev | tr -d '-')
  fi

  if [ "connected" == "$status" ]
  then 
    echo $dev "connected"
    declare $dev="yes"; 
  
  fi
done <<< "$DEVICES"


if [ ! -z "$HDMI1" -a ! -z "$eDP1" ]
then
  echo "HDMI1 and eDP1 are plugged in"
  /usr/bin/xrandr --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 1920x536 --rotate normal && /home/davide/audio-toggle-sink.sh 0
elif [ ! -z "$HDMI1" -a -z "$VGA1" ]; then
  echo "HDMI1 is plugged in, but not eDP1"
elif [ -z "$HDMI1" -a ! -z "$VGA1" ]; then
  echo "VGA1 is plugged in, but not HDMI1"
else
  echo "No external monitors are plugged in"
  /usr/bin/xrandr --auto && /home/davide/audio-toggle-sink.sh 1
fi
