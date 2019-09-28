#!/bin/sh

# Automatically configure the second monitor
#MONITOR1=eDP1
#MONITOR2=DP2
#xrandr --output $MONITOR2 --off
#xrandr --output $MONITOR2 --auto --right-of $MONITOR1

# a temporary fix for LibreOffice + xmonad
# (https://code.google.com/archive/p/xmonad/issues/200)
export SAL_USE_VCLPLUGIN=gen

# map CapsLock to be an Escape button equivalent (for easier vim use)
# also, configure keyboard layout switching via Shift+CapsLock
setxkbmap -layout "us,ru,ua,us(intl)" -option grp:shift_caps_toggle -option grp_led:scroll -option caps:escape

# this is needed for lightdm to actually lock screen, otherwise it asks no password to unlock
# light-locker &

# configure system tray for use with xmonad/xmobar
trayer \
    --SetDockType true \
    --SetPartialStrut true \
    --tint 0x000000 \
    --transparent true \
    --height 16 \
    --edge bottom \
    --align left \
    --monitor 0 \
    --widthtype percent \
    --width 5 \
    &  # send to background

feh --bg-max --randomize --recursive --draw-filename ~/backgrounds/ &

# exec xmonad
exec i3
