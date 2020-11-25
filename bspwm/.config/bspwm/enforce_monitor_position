#! /bin/sh

MON_ID=$(bspc query -M -m "$1")
MON_POS="$2"

[ $(bspc query -M -m "$MON_POS") != "$MON_ID" ] && bspc monitor "$MON_POS" -s "$MON_ID"

bspc subscribe monitor_swap | while read msg ; do
	[ $(bspc query -M -m "$MON_POS") != "$MON_ID" ] && bspc monitor "$MON_POS" -s "$MON_ID"
done
