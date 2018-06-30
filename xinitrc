#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# /usr/bin/VBoxClient-all

# set CapsLock to Ctrl & Escape, and Shift_L + Shift_R to CapsLock
# check XKB options with:
# grep -E "(ctrl|caps|shift|alt|win|super):" /usr/share/X11/xkb/rules/base.lst
setxkbmap -option ctrl:nocaps,shift:both_capslock
xcape

# Here Xfce is kept as default
session=${1:-bspwm}

case $session in
    bsp|bspwm         ) exec bspwm;;
    i3|i3wm           ) exec i3;;
    openbox           ) exec openbox-session;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac

