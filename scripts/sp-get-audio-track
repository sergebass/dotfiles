#!/bin/sh

# the sed command is here to trim redundant whitespace (as emitted by some radio stations)
(mpc -f '[%title% ][@%name%]' current || echo '--') | sed 's/  \+/ /g'
