#!/bin/sh

# map CapsLock to be an Escape button equivalent (for easier vim use)
# also, configure keyboard layout switching via Shift+CapsLock
setxkbmap -layout "us,ru,ua,us(intl)" -option grp:shift_caps_toggle -option grp_led:scroll -option caps:escape

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
