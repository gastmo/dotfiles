# ~/.profile
#
# set environment common to both Zsh and Bash

export EDITOR="vim"
export VISUAL="vim"
export BROWSER="vimb"

# nnn variables

export NNN_BMS='d:~/Documents;D:~/Downloads;p:~/Pictures;v:~/Videos;m:~/Music;w:~/Working'
export NNN_USE_EDITOR=1
export DISABLE_FILE_OPEN_ON_NAV=1


# set CapsLock to Ctrl & Escape, and Shift_L + Shift_R to CapsLock
# check XKB options with:
# grep -E "(ctrl|caps|shift|alt|win|super):" /usr/share/X11/xkb/rules/base.lst

setxkbmap -option ctrl:nocaps,shift:both_capslock
xcape &

