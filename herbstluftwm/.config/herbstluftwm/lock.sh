#!/bin/bash
bat=$(acpi -a)
if [ "$bat" = "Adapter 0: on-line" ]; then
    notify-send -u critical 'LOCKING in 30s'
    sleep 30
    locker
else
    notify-send -u critical 'SUSPENDING in 30s'
    sleep 30
    systemctl suspend
fi
