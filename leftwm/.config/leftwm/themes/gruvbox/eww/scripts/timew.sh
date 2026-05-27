#!/usr/bin/env bash
command -v timew-i3block >/dev/null 2>&1 || exit 0
timew-i3block 2>/dev/null || true
