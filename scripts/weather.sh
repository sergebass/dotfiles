#!/bin/bash

echo "Ottawa $(metar -d CYOW | grep Temperature)"
