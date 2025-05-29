#!/usr/bin/env bash

# This task depends on imagemagick, potrace (https://potrace.sourceforge.net/), sed and
# fd (fd-find).
#
# The SVG manipulation and use of an extra CSS file was brilliantly explained here:
# https://github.com/rust-lang/book/issues/74#issuecomment-2007681424

converter() {
    # Remove edges
    # magick "$1" -flatten -fuzz 1% -trim +repage "$1"
    # Convert from PNG to BMP (bitmap).
    magick "$1" -alpha off "$2".bmp

    # Convert from BMP to SVG.
    potrace -s "$2".bmp
    rm "$2".bmp

    # Edit SVG to dynamically change colour between dark and light.
    sed -i '10 i <defs> <style> :root { color: #1e1e1e; } @media (prefers-color-scheme: dark) { :root { color: #d3d3d3; } } </style> </defs>' "$2".svg

    # Replace all black (#000000) with currentColor.
    sed -i 's/#000000/currentColor/g' "$2".svg

    # This should be done immediately after capturing the screenshot, so deleting the
    # original PNG should be the preferred behaviour.
    rm "$1"
}
export -f converter

# Copy-pasta from
# https://unix.stackexchange.com/a/50695
# Find all PNG's in a svg directory.
fd -e png -p svg -x bash -c 'converter "$@"' bash {} {.} +
