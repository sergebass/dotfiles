#!/usr/bin/env bash
# $1: root of the filesystem/directory tree where the failed files are searched

dmesg | grep -Po 'csum failed root \d+ ino\S* \d+' | awk '{print $6}' | sort -nu | xargs -n 1 find $1 -inum 2> /dev/null
