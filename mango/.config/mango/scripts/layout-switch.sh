#!/usr/bin/env bash

has() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "$1 is not installed. Adjust $0 if you think you do not need it."
        notify-send "$1 is not installed" "Install from https://github.com/DreamMaoMao/mangowc/ or adjust $0 if you think you do not need it."
        exit 1
    fi
}

has mmsg

# Create a mapping of short codes to descriptions
declare -A layout_map=(
    ["T"]="tile: Master tile left, new tiles stack vertically to the right"
    ["S"]="scroller: Scroll tiles horizontally"
    ["M"]="monocle: Focus only one tile across the whole tag"
    ["K"]="deck: Show main and second tile, where all other windows are stacked"
    ["G"]="grid: Equal size to all tiles, filling the screen as much as possible"
    ["CT"]="center tile: Place the main tile in the centre"
    ["VT"]="vertical tile: Master tile above, new tiles stack horizontally below"
    ["RT"]="right tile: Master tile right, new tiles stack vertically to the left"
    ["VS"]="vertical scroller: Scroll tiles vertically"
    ["VG"]="vertical grid: Same as 'grid', but filling in the vertical direction first"
    ["VK"]="vertical deck: Show main and second tile, where all other windows are stacked"
    ["DW"]="dwindle: new windows are created in the bottom right corner"
    ["F"]="fair: Like 'tile' for few windos, and 'grid' as windows are added."
    ["VF"]="vetical fair: Like 'tile' for few windos, and 'grid' as windows are added."
)

available_layouts="T
S
M
K
G
CT
VT
RT
VS
VG
VK
DW
F
VF"

declare -A layout_codes=(
    ["T"]="tile"
    ["S"]="scroller"
    ["M"]="monocle"
    ["K"]="deck"
    ["G"]="grid"
    ["CT"]="center_tile"
    ["VT"]="vertical_tile"
    ["RT"]="right_tile"
    ["VS"]="vertical_scroller"
    ["VG"]="vertical_grid"
    ["VK"]="vertical_deck"
    ["DW"]="dwindle"
    ["F"]="fair"
    ["VF"]="vertical_fair"
)

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
short_code=${layout_codes[$short_code]}

# Apply the layout if one was chosen
if [[ -n $short_code ]]; then
    mmsg dispatch setlayout,"$short_code"
fi
