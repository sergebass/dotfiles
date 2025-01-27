#!/bin/sh
amixer get $1 | awk -F '[][]' '/dB/ { print $2 }'
