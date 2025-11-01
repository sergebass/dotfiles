#!/usr/bin/env bash
# $1 - Path to the image file to set as user avatar, e.g. ~/.face

dbus-send --system --dest=org.freedesktop.Accounts --type=method_call --print-reply=literal /org/freedesktop/Accounts/User$(id -u) org.freedesktop.Accounts.User.SetIconFile string:"$1"
