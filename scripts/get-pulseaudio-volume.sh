#!/bin/sh
pactl list sinks | grep '^[[:space:]]Volume:' | sed -e 's,.* \([0-9][0-9]*%\).*,\1,' | tr '\n' ' ' | xargs
