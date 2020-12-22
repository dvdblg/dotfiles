#!/bin/sh

hotkeysRC="$HOME/.config/kglobalshortcutsrc"

# Remove application launching shortcuts.
sed -i 's/_launch=[^,]*/_launch=none/g' $hotkeysRC

# Remove other global shortcuts.
sed -i 's/^\([^_].*\)=[^,]*/\1=none/g' $hotkeysRC

# Reload hotkeys.
kquitapp5 kglobalaccel && sleep 2s && kglobalaccel5 &
