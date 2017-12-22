# map CapsLock to be an Escape button equivalent (for easier vim use)
setxkbmap -option caps:escape

if [ -f $HOME/.Xdefaults ]; then
  xrdb -merge $HOME/.Xdefaults
fi

if [ -f $HOME/.xinitrc ]; then
  $HOME/.xinitrc
fi
