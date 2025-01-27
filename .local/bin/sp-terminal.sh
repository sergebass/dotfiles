#!/bin/bash
# FIXME make a Haskell implementation of the script below, to work with xmonad better.

T1=$HOME/.cargo/bin/alacritty_ # FIXME temporarily mangled, will be restored when properly configured
P1=

T2=/usr/bin/urxvt
P2=-vb +sb -bc -cr orange -fg '#c0c0c0' -bg '#002020' -fn 'xft:Inconsolata:style=medium:pixelsize=14:antialias=true:hintstyle=hintslight' -letsp -1 -fade 10

T3=/usr/bin/xfce4-terminal
P3=

T4=/usr/bin/gnome-terminal
P4=

# Check availability of terminal emulators in order of preference
# and launch one as soon as it's found
if [ -x $T1 ]; then
    $T1 $P1;
elif [ -x $T2 ]; then
    $T2 $P2;
elif [ -x $T3 ]; then
    $T3 $P3;
else
    $T4 $P4;
fi
