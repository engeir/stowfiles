#!/usr/bin/env bash
IDX="${MONITOR_IDX:-0}"
leftwm-state -w "$IDX" -s -t "{{layout}}"
