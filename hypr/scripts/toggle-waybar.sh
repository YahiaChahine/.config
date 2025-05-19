#!/bin/bash

# Check if Waybar is running
if pgrep -x "waybar" > /dev/null; then
    # Kill Waybar if running
    pkill -x waybar
    # Ensure all instances are killed (sometimes needed)
    sleep 0.5
    if pgrep -x "waybar" > /dev/null; then
        pkill -9 -x waybar
    fi
else
    # Start Waybar if not running
    waybar &
fi
