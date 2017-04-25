#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Set cursor to left pointer instead of a cross
xsetroot -cursor_name left_ptr

# numlock on by default
numlockx on

# set keyboard layout
setxkbmap it

# Set display stanby time
xset dpms 600 1200 1800

# Set dpi
xrandr --dpi 100.45

# Set modmap
xmodmap ~/.Xmodmap

 D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

compton -b

# Start the WM
#exec bspwm
#exec mate-session
#exec i3
#startxfce4
#exec openbox-session
#exec gnome-session
