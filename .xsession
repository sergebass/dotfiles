if [ -f $HOME/.Xdefaults ]; then
  xrdb -merge $HOME/.Xdefaults
fi

if [ -f $HOME/.xinitrc ]; then
  $HOME/.xinitrc
fi
