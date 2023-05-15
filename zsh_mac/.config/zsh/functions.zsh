#!/bin/sh
batdiff() {
    if [ "$1" = "--staged" ]; then
        git diff --staged --name-only --diff-filter=d | xargs -I % sh -c "git diff --staged % | bat"
    else
        git diff --name-only --diff-filter=d | xargs bat --diff
    fi
}

cht() {
	# Cheat sheet for any command you can think of.
	curl cht.sh/"$1"
}

lc () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir" || exit 1
            fi
        fi
    fi
}

nn ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -deH "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

nnn_preview() {
    # Block nesting of nnn in subshells
    if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi
    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # This will create a fifo where all nnn selections will be written to
    NNN_FIFO="$(mktemp --suffix=-nnn -u)"
    export NNN_FIFO
    (
        umask 077
        mkfifo "$NNN_FIFO"
    )
    # Preview command
    preview_cmd="/path/to/preview_cmd.sh"
    if [ -e "${TMUX%%,*}" ]; then
        # Use `tmux` split as preview
        tmux split-window -e "NNN_FIFO=$NNN_FIFO" -dh "$preview_cmd"
    elif (which xterm &>/dev/null); then
        # Use `xterm` as a preview window
        xterm -e "$preview_cmd" &
    else
        # Unable to find a program to use as a preview window
        echo "unable to open preview, please install tmux or xterm"
    fi
    nnn "$@"
    rm -f "$NNN_FIFO"
}

# Pyenv take up to 0.5 seconds extra, so we wrap it in a function
if command -v pyenv 1>/dev/null 2>&1; then
    pyenvinit () {
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    }
fi

# Pip take up to 1 second extra, so we wrap it in a function
if command -v pip 1>/dev/null 2>&1; then
    pipinit () {
        eval "$(pip completion --zsh)"
    }
fi

peek() {
    # cat a file that is on PATH
    cat "$(which "$1")"
}
compdef _whereis peek

nvp() {
    # edit a file that is on PATH
    if [ -z "$1" ]; then
        echo "Usage: edit a file on PATH with neovim. Any argument that works with whereis works with nvp as well."
    else
        nvim "$(which "$1")"
    fi
}
compdef _whereis nvp

# # Change cursor for vi modes:
# zle_keymap_select() {
#     if [[ $KEYMAP == vicmd ]] ||
#         [[ $1 = 'block' ]]; then
#         echo -ne '\e[1 q'
#     elif [[ $KEYMAP == main ]] ||
#         [[ $KEYMAP == viins ]] ||
#         [[ $KEYMAP = '' ]] ||
#         [[ $1 = 'beam' ]]; then
#         echo -ne '\e[5 q'
#     fi
# }
# zle -N zle_keymap_select
# zle_line_init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle_line_init
# echo -ne '\e[5 q'                # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.

if [ "$MACHINE" = "Darwin" ]; then
    plug "$HOME/.config/zsh/mac-specific.zsh"
fi
if [ "$MACHINE" = "Ubuntu" ]; then
    plug "$HOME/.config/zsh/linux-specific.zsh"
fi
