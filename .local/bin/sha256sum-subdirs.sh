#!/usr/bin/env bash
# This scripts computes the sha256sum of all files in the given directories.
# (files as arguments are also supported)

dirs="$@"

for dir in "$@"; do
    checksumFile="$dir.sha256"
    echo "Generating '$checksumFile'" >&2
    # Use `tee` to provide visual indication of progress
    find "$dir" -type f -printf '%p\n' | sort | xargs -l1 -d '\n' sha256sum | tee "$checksumFile"
    echo "Done generating '$checksumFile'" >&2
done
