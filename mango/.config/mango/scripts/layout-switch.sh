#!/usr/bin/env bash

if ! command -v mmsg >/dev/null 2>&1; then
    notify-send "mmsg not installed" "Install from https://github.com/DreamMaoMao/mangowc/"
    exit 1
fi

# Create a mapping of short codes to descriptions
declare -A layout_map=(
    ["T"]="tile: Master tile to the left, new tiles stack vertically to the right"
    ["S"]="scroller: Scroll tiles horizontally"
    ["G"]="grid: Equal size to all tiles, filling the screen as much as possible"
    ["M"]="monocle: Focus only one tile across the whole tag"
    ["K"]="deck: Show the main tile and a second tile, where all other windows are stacked"
    ["CT"]="center tile: Place the main tile in the centre"
    ["RT"]="right tile: Master tile to the right, new tiles stack vertically to the left"
    ["VS"]="vertical scroller: Scroll tiles vertically"
    ["VT"]="vertical tile: Master tile above, new tiles stack horizontally below"
    ["VG"]="vertical grid: Same as 'grid', but filling in the vertical direction first"
    ["VK"]="vertical deck: Show the main tile and a second tile, where all other windows are stacked"
    ["DW"]="dwindle: new windows are created in the bottom right corner"
    ["F"]="fair: Like 'tile' for few windos, and similar to 'grid' as windows are added."
    ["VF"]="vetical fair: Like 'tile' for few windos, but like 'grid' as windows are added."
)

# Get available layouts from mmsg
available_layouts=$(mmsg -L)

# Build the fuzzel input with descriptions and find the longest line
fuzzel_input=""
max_length=0
while IFS= read -r layout; do
    if [[ -n ${layout_map[$layout]} ]]; then
        line="$layout - ${layout_map[$layout]}"
        fuzzel_input+="$line"$'\n'
        # Track the longest line length
        if ((${#line} > max_length)); then
            max_length=${#line}
        fi
    else
        fuzzel_input+="$layout"$'\n'
        if ((${#layout} > max_length)); then
            max_length=${#layout}
        fi
    fi
done <<<"$available_layouts"

# Show fuzzel with descriptions, width based on longest option
chosen=$(echo -n "$fuzzel_input" | fuzzel -w "$max_length" -d -p "Layout: ")

# Extract just the short code (before the " - ")
short_code="${chosen%% -*}"

# Apply the layout if one was chosen
if [[ -n $short_code ]]; then
    mmsg -l "$short_code"
fi
