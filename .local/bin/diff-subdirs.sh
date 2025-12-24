#!/usr/bin/env bash
# This scripts computes the sha256sum of all files in two directory trees,
# sorts the results, and opens them in nvim's diff mode for easy comparison.

dir1="$1"
dir2="$2"

# Use `tee` to provide visual indication of progress
find $dir1 -type f -exec sha256sum {} \; | tee /tmp/a
find $dir2 -type f -exec sha256sum {} \; | tee /tmp/b

echo "Sorting results for $1..."
sort /tmp/a > /tmp/a-sorted

echo "Sorting results for $2..."
sort /tmp/b > /tmp/b-sorted

nvim -d /tmp/a-sorted /tmp/b-sorted
