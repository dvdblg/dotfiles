#!/bin/bash

"$HOME/.profile"
"$HOME/.local/bin/preprocess_configs.sh"


killall -q polybar
killall -q picom
killall -q dunst
killall -q fusuma
#killall -q notify_battery
#killall -q flashfocus
#killall -q xautolock
#killall -q plasmashell
#killall gnome-flashback
killall -q redshift

kglobalaccel5 &
#dunst &
picom --backend glx --experimental-backends -bc &
#polybar bar &
#"$HOME/.config/herbstluftwm/notify_battery" &
fusuma -d &
#flashfocus &
#xautolock -time 20 -detectsleep -locker "$HOME/.config/herbstluftwm/lock.sh" &
#xautolock -time 20 -detectsleep -locker locker &
#nitrogen --restore &
#redshift &


