#!/bin/sh

mpc -f '[%title% ][@%name%][=%id%]' current || echo '!!'
