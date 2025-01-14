#!/usr/bin/env bash

read -r -p "Enter Search: " search

if ! command -v oi &>/dev/null; then
    # If this script is run with `tmux neww ...`
    # tmux neww bash -c "echo 'Command oi is not in PATH' | less"
    # If this script is run with `tmux popup ...`
    echo 'Command oi is not in PATH'
else
    # If this script is run with `tmux neww ...`
    # tmux neww bash -c "oi $search | less"
    # tmux popup "oi $search"
    # If this script is run with `tmux popup ...`
    oi "$search"
fi
