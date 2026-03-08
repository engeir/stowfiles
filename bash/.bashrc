#
# ~/.bashrc
#

# Exit if non-interactive
[[ $- != *i* ]] && return

# ── PATH ────────────────────────────────────────────────────────────────────────
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.pixi/bin:$PATH"

# ── HISTORY ─────────────────────────────────────────────────────────────────────
HISTSIZE=9999
HISTFILESIZE=9999
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:ll:exit:cd:.."
HISTFILE="$HOME/.local/share/bash/.bash_history"
shopt -s histappend

# ── SHELL OPTIONS ───────────────────────────────────────────────────────────────
shopt -s checkwinsize
shopt -s globstar
shopt -s cdspell
shopt -s autocd 2>/dev/null  # bash 4+

# ── VI MODE ─────────────────────────────────────────────────────────────────────
set -o vi
if [[ -z "${BRUSH_VERSION:-}" ]]; then
    # History search in insert mode
    bind '"\C-r": reverse-search-history'
    bind '"\C-s": forward-search-history'
    # History search with j/k in normal mode (via readline vi-movement-keymap)
    bind -m vi-command '"\C-r": reverse-search-history'
    bind -m vi-command '"k": history-search-backward'
    bind -m vi-command '"j": history-search-forward'
fi

# ── GPG / SSH ───────────────────────────────────────────────────────────────────
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

# ── TOOL INTEGRATIONS (cached) ───────────────────────────────────────────────────
_bashrc_setup_tools() {
    local _dir="${XDG_CACHE_HOME:-$HOME/.cache}/bash"
    mkdir -p "$_dir"

    _zi() {
        local cache="$_dir/$1.bash" bin
        bin="$(command -v "$2" 2>/dev/null)"
        shift 2
        if [[ ! -f "$cache" ]] || { [[ -n "$bin" ]] && [[ "$bin" -nt "$cache" ]]; }; then
            "$@" >| "$cache" 2>/dev/null
        fi
        # shellcheck disable=SC1090
        source "$cache" 2>/dev/null
    }

    _zi mise      mise      mise activate bash
    _zi fzf       fzf       fzf --bash
    _zi zoxide    zoxide    zoxide init --cmd cd bash
    _zi batpipe   batpipe   batpipe
    _zi batman    batman    batman --export-env
    if command -v navi >/dev/null 2>&1; then
        _zi navi  navi      navi widget bash
    fi

    unset -f _zi
}
if [[ -z "${BRUSH_VERSION:-}" ]]; then
    _bashrc_setup_tools
fi
unset -f _bashrc_setup_tools

# Atuin — init after cache block so ATUIN_SESSION is unique per shell
if [[ -z "${BRUSH_VERSION:-}" ]]; then
    [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
    eval "$(atuin init bash 2>/dev/null)"
    export ATUIN_SESSION="$(</proc/sys/kernel/random/uuid)"
fi

# Starship prompt (last, so it wraps any prompt set above)
eval "$(starship init bash 2>/dev/null)"

# ── COMPLETIONS (cached) ─────────────────────────────────────────────────────────
# bash-completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

_bashrc_setup_completions() {
    local _comp_dir="${XDG_CACHE_HOME:-$HOME/.cache}/bash/completions"
    mkdir -p "$_comp_dir"

    _gc() {
        local out="$_comp_dir/$1.bash" bin
        bin="$(command -v "$2" 2>/dev/null)"
        shift 2
        [[ -z "$bin" ]] && return
        if [[ ! -f "$out" ]] || [[ "$bin" -nt "$out" ]]; then
            "$@" >| "$out" 2>/dev/null
        fi
        # shellcheck disable=SC1090
        source "$out" 2>/dev/null
    }

    _gc mise  mise  mise completion bash
    _gc aqua  aqua  aqua completion bash
    _gc just  just  just --completions bash
    _gc uv    uv    uv generate-shell-completion bash
    _gc pixi  pixi  pixi completion --shell bash
    _gc jj    jj    jj util completion bash

    unset -f _gc
}
_bashrc_setup_completions
unset -f _bashrc_setup_completions

# ── ALIASES ─────────────────────────────────────────────────────────────────────
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ── FUNCTIONS ───────────────────────────────────────────────────────────────────

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

lc() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$PWD" ]; then
                cd "$dir" || exit 1
            fi
        fi
    fi
}

fif() {
    # find-in-file <search-term>
    if [ ! "$#" -gt 0 ]; then
        echo "Need a string to search for!"
        return 1
    fi
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

mkcd() {
    # make a directory and cd to it
    test -d "$1" || mkdir -p "$1" && cd "$1"
}

mktp() {
    # make a random directory and cd to it
    here="$(mktemp -d /tmp/tmp.XXXXXX)"
    cd "$here" || exit 1
}

y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ "$cwd" != "" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

nn() {
    # Block nesting of nnn in subshells
    if [ "$NNNLVL" != "" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn -deH "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" >/dev/null
    fi
}

nnn_preview() {
    # Block nesting of nnn in subshells
    if [ "$NNNLVL" != "" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    NNN_FIFO="$(mktemp --suffix=-nnn -u)"
    export NNN_FIFO
    (
        umask 077
        mkfifo "$NNN_FIFO"
    )
    preview_cmd="/path/to/preview_cmd.sh"
    if [ -e "${TMUX%%,*}" ]; then
        tmux split-window -e "NNN_FIFO=$NNN_FIFO" -dh "$preview_cmd"
    elif command -v xterm >/dev/null 2>&1; then
        xterm -e "$preview_cmd" &
    else
        echo "unable to open preview, please install tmux or xterm"
    fi
    nnn "$@"
    rm -f "$NNN_FIFO"
}

if command -v pyenv >/dev/null 2>&1; then
    pyenvinit() {
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    }
fi

if command -v pip >/dev/null 2>&1; then
    pipinit() {
        eval "$(pip completion --bash)"
    }
fi

if command -v python >/dev/null 2>&1; then
    pyvenv() {
        PYVERSION=$(python -c 'import sys; pv=sys.version_info[:3]; print(pv[0]*100+pv[1]>309)')
        if [ "$PYVERSION" = "True" ]; then
            python -m venv --prompt . --upgrade-deps .venv
        else
            python -m venv --prompt . .venv
        fi
        source .venv/bin/activate
    }
fi

peek() {
    # cat a file that is on PATH
    cat "$(which "$1")"
}

nvp() {
    # edit a file that is on PATH with neovim
    if [ "$1" = "" ]; then
        echo "Usage: edit a file on PATH with neovim. Any argument that works with whereis works with nvp as well."
    else
        nvim "$(which "$1")"
    fi
}

pdf-reduce() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf "$1"
}

# ripgrep->fzf->nvim [QUERY]
r() { (
    RELOAD='reload:rg --hidden --glob "!.git" --column --color=always --smart-case {q} || :'
    OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}
          else
            nvim +cw -q {+f}
          fi'
    fzf </dev/null \
        --disabled --ansi --multi \
        --bind "start:$RELOAD" --bind "change:$RELOAD" \
        --bind "enter:become:$OPENER" \
        --bind "ctrl-o:execute:$OPENER" \
        --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
        --delimiter : \
        --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
        --preview-window '~4,+{2}+4/3,<80(up)' \
        --query "$*"
); }

evalssh() {
    eval "$(ssh-agent -s)"
}
