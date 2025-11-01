#!/usr/bin/env bash
dmesg | grep -Po 'csum failed root \d+ ino\S* \d+' | awk '{print $6}' | sort -nu
