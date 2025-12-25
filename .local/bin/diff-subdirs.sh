#!/usr/bin/env bash
# This scripts computes the sha256sum of all files in two directory trees,
# sorts the results, and opens them in nvim's diff mode for easy comparison.

dir1="$1"
dir2="$2"

files1=$(mktemp /tmp/diff-subdirs-A-XXXX)
files2=$(mktemp /tmp/diff-subdirs-B-XXXX)

# Use `tee` to provide visual indication of progress
time find "$dir1" -type f -printf '%p\n' | sort | xargs -l1 -d '\n' sha256sum | tee "$files1"
time find "$dir2" -type f -printf '%p\n' | sort | xargs -l1 -d '\n' sha256sum | tee "$files2"

echo "Comparing file hashes: '$files1' vs '$files2'"

# Open neovim in diff mode to see the differences
nvim -d "$files1" "$files2"

# TODO: Keep temp files on exit (if a specific flag is given)
rm --verbose "$files1" "$files2"
