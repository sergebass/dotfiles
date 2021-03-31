#!/bin/sh

# a temporary fix for LibreOffice + xmonad
# (https://code.google.com/archive/p/xmonad/issues/200)
export SAL_USE_VCLPLUGIN=gen

# on a US keyboard, make sure right Alt (mod3 in xmonad) is different from left Alt
xmodmap -e 'clear Mod1'
xmodmap -e 'add Mod1 = Alt_L Meta_L'
xmodmap -e 'add Mod3 = Alt_R'

# map CapsLock to be an Escape button equivalent (for easier vim use)
# also, configure keyboard layout switching via Shift+CapsLock
setxkbmap -layout "us,ru,ua,us(intl)" -option grp:shifts_toggle -option grp:shift_caps_toggle -option grp_led:scroll -option caps:escape

# Automatically configure the second monitor
#MONITOR1=eDP1
#MONITOR2=DP2
#xrandr --output $MONITOR2 --off
#xrandr --output $MONITOR2 --auto --right-of $MONITOR1

xsetroot -solid '#002020' -cursor_name left_ptr

xrdb -merge ~/.Xresources

feh --bg-max --randomize --recursive --draw-filename ~/backgrounds/ &

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

# need to run this or dm-tool cannot lock screen otherwise
# light-locker &

# USB storage automounter
udiskie &

# a Network Manager applet to make it easier to manage network connections (especially Wi-Fi)
nm-applet &

# if you use startx, specify WM like this:
# startx `which i3`
