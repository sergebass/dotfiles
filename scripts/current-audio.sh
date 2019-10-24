#!/bin/sh

mpc -f '[%title% ][@%name%]' current || echo '--'
