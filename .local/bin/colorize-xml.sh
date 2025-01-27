#!/bin/sh

xmllint --format - | source-highlight -s xml -f esc
