#!/bin/bash

echo "☀$(metar -d CYOW | grep Temperature | cut -d ":" -f 2-)"
