#!/usr/bin/env sh
# An easier way to reference ANSI terminal colors
# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

# See `man 5 terminfo` for description of terminal control parameters used with `tput`
export COLOR_RESET=$(tput sgr0)

export FG_BLACK=$(tput setaf 0)
export FG_RED=$(tput setaf 1)
export FG_GREEN=$(tput setaf 2)
export FG_YELLOW=$(tput setaf 3)
export FG_BROWN=$(tput setaf 3)
export FG_BLUE=$(tput setaf 4)
export FG_MAGENTA=$(tput setaf 5)
export FG_CYAN=$(tput setaf 6)
export FG_WHITE=$(tput setaf 7)

export FG_GRAY=$(tput setaf 8)
export FG_HI_RED=$(tput setaf 9)
export FG_HI_GREEN=$(tput setaf 10)
export FG_HI_YELLOW=$(tput setaf 11)
export FG_HI_BLUE=$(tput setaf 12)
export FG_HI_MAGENTA=$(tput setaf 13)
export FG_HI_CYAN=$(tput setaf 14)
export FG_HI_WHITE=$(tput setaf 15)

export BG_BLACK=$(tput setab 0)
export BG_RED=$(tput setab 1)
export BG_GREEN=$(tput setab 2)
export BG_YELLOW=$(tput setab 3)
export BG_BROWN=$(tput setab 3)
export BG_BLUE=$(tput setab 4)
export BG_MAGENTA=$(tput setab 5)
export BG_CYAN=$(tput setab 6)
export BG_WHITE=$(tput setab 7)

export BG_GRAY=$(tput setab 8)
export BG_HI_RED=$(tput setab 9)
export BG_HI_GREEN=$(tput setab 10)
export BG_HI_YELLOW=$(tput setab 11)
export BG_HI_BLUE=$(tput setab 12)
export BG_HI_MAGENTA=$(tput setab 13)
export BG_HI_CYAN=$(tput setab 14)
export BG_HI_WHITE=$(tput setab 15)

export BOLD=$(tput bold)

export STANDOUT_ON=$(tput smso)
export STANDOUT_OFF=$(tput rmso)

export UNDERLINE_ON=$(tput smul)
export UNDERLINE_OFF=$(tput rmul)
