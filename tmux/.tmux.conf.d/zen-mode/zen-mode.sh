#!/usr/bin/bash
# Tmux Zen Mode - Center your terminal
# Usage: tmux-zen.sh [width]
#
# https://github.com/akr411/dotfiles/blob/main/.config/tmux/scripts/tmux-zen.sh

CENTER_WIDTH="${1:-120}"

CURRENT_PANE=$(tmux display-message -p '#{pane_id}')
PANE_COUNT=$(tmux display-message -p '#{window_panes}')
WINDOW_WIDTH=$(tmux display-message -p '#{window_width}')

# Check if we're already in zen mode
is_zen_mode() {
    [ "$PANE_COUNT" -eq 3 ]
}

create_zen() {
    if is_zen_mode; then
        return
    fi

    if [ "$PANE_COUNT" -ne 1 ]; then
        tmux display-message "Zen mode: single pane only"
        return
    fi

    TOTAL_MARGIN=$((WINDOW_WIDTH - CENTER_WIDTH - 2))
    if [ "$TOTAL_MARGIN" -lt 10 ]; then
        tmux display-message "Zen mode: window too narrow"
        return
    fi

    SIDE_WIDTH=$((TOTAL_MARGIN / 2))

    tmux split-window -hdt "$CURRENT_PANE" "cat"
    tmux split-window -hbdt "$CURRENT_PANE" "cat"

    tmux select-layout even-horizontal
    tmux resize-pane -t "$CURRENT_PANE" -x "$CENTER_WIDTH"

    tmux list-panes -F '#{pane_id}' | while read -r pane; do
        if [ "$pane" != "$CURRENT_PANE" ]; then
            pane_command=$(tmux display-message -p -t "$pane" '#{pane_current_command}')
            if [ "$pane_command" = "cat" ]; then
                tmux resize-pane -t "$pane" -x "$SIDE_WIDTH"
            fi
        fi
    done
}

destroy_zen() {
    if ! is_zen_mode; then
        return
    fi

    tmux list-panes -F '#{pane_id}' | while read -r pane; do
        pane_command=$(tmux display-message -p -t "$pane" '#{pane_current_command}')
        if [ "$pane_command" = "cat" ]; then
            tmux kill-pane -t "$pane"
        fi
    done
}

toggle_zen() {
    if is_zen_mode; then
        destroy_zen
    else
        create_zen
    fi
}

toggle_zen
