#!/usr/bin/env bash
#
# From ThePrimeagen:
# https://www.youtube.com/watch?v=hJzqEAf2U4I
#

selected=$(cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=$(echo "$query" | tr ' ' '+')
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
