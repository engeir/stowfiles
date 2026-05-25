#!/usr/bin/env bash
# current timewarrior tag for bar widget
tag=$(timew get dom.active.tag.1 2>/dev/null)
if [ -z "$tag" ] || [ "$tag" = "0" ]; then
    printf " -"
else
    printf "  %s" "$tag"
fi
