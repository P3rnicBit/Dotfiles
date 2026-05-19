#!/bin/bash
# Screenshot - A script to take a screenshot and copy it to clipboard
screenshot_file=~/Pictures/Screenshots/Screenshot-$(date +"%d.%b.%Y-%H:%M:%S").png
slurp | grim -g - "$screenshot_file"
cat "$screenshot_file" | wl-copy
