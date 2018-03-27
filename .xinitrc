#!/bin/sh

# map CapsLock to be an Escape button equivalent (for easier vim use)
# also, configure keyboard layout switching via Shift+CapsLock
setxkbmap -layout "us,ru,ua,us(intl)" -option grp:shift_caps_toggle -option grp_led:scroll -option caps:escape
