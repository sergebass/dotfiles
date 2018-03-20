#!/bin/bash

echo "Ottawa$(metar -d CYOW | grep Temperature | cut -d ":" -f 2-)"
