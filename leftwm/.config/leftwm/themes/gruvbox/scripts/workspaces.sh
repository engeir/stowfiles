#!/usr/bin/env bash
# polybar tag display via leftwm-state; MONITOR_IDX env selects the workspace
IDX="${MONITOR_IDX:-0}"
BG_FOCUS="#DA7510"
FG_FOCUS="#201b14"
FG_VISIBLE="#D1B88E"
FG_OCCUPIED="#c9b890"
FG_EMPTY="#444444"

leftwm-state -w "$IDX" -s -t \
"{{#tags}}{{#focused}}%{B${BG_FOCUS}}%{F${FG_FOCUS}} {{name}} %{F-}%{B-}{{/focused}}{{^focused}}{{#visible}}%{F${FG_VISIBLE}} {{name}} %{F-}{{/visible}}{{^visible}}{{#occupied}}%{F${FG_OCCUPIED}} {{name}} %{F-}{{/occupied}}{{^occupied}}%{F${FG_EMPTY}} {{name}} %{F-}{{/occupied}}{{/visible}}{{/focused}}{{/tags}}"
