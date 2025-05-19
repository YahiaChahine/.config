#!/bin/bash

# Fixed Screenshot Script for Hyprland
# No more freezes or duplicate screenshots

time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$HOME/Pictures/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"

# Create directory if needed
mkdir -p "$dir"

# Notification function
notify_shot() {
    notify-send -h string:x-canonical-private-synchronous:shot-notify \
               -u low "$1" "$2"
}

# Take screenshot without freezing
take_shot() {
    local args="$1"
    if grim $args "$dir/$file"; then
        wl-copy < "$dir/$file"
        notify_shot "Screenshot Saved" "$dir/$file"
    else
        notify_shot "Screenshot Cancelled" ""
    fi
}

# Handle different modes
case "$1" in
    "--now")
        take_shot ""
        ;;
    "--area")
        take_shot "-g \"$(slurp)\""
        ;;
    "--win")
        geometry=$(hyprctl activewindow | awk '
            /at:/ {x=$2; y=$3}
            /size:/ {w=$2; h=$3}
            END {print x","y" "w"x"h}'
        )
        take_shot "-g \"$geometry\""
        ;;
    *)
        echo "Usage: $0 [--now|--area|--win]"
        exit 1
        ;;
esac

exit 0
