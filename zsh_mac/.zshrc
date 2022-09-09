export PATH="${PATH}:${HOME}/.local/bin"
# 
# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$HOME/scripts:$HOME/.local/bin:$HOME/bin:$PATH
export NODE_PATH='/usr/local/lib/node_modules'
# export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/Users/eirikenger/Library/Python/3.9/bin:$PATH"
export PATH=/usr/local/opt/ruby/bin:$PATH  # Ruby path
export PATH=/Applications/ConTeXtStandalone/tex/texmf-osx-64/bin:$PATH  # ConTeXt path

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL="alacritty"
export TERM=screen-256color  # Needed for italics to work in tmux
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PAGER=less  # Suggested at https://github.com/jarun/nnn/wiki/Advanced-use-cases#pager-as-opener
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESS='-Ri '
# export LS_COLORS="$(vivid generate nord)"
export LS_COLORS="$(vivid generate solarized-dark)"

fpath+=${ZDOTDIR:-~}/.zsh_functions  # This must come before compinit

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle :compinstall filename '/home/een023/.config/zsh/.zshrc'

autoload -Uz compinit
compinit  # Slows down the prompt. Just call it manually when in need
_comp_options+=(globdots)  # Includes hidden files
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
# HISTFILE=~/.cache/zsh/.histfile
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

export KEYTIMEOUT=1

# Search history for input with the up- and down-arrow
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# Edit line in vim with ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# User configuration

# # Virtualenvwrapper settings:
# export WORKON_HOME=$HOME/.virtualenvs
# VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# . /usr/local/bin/virtualenvwrapper.sh

# export MANPATH="/usr/local/man:$MANPATH"

# NNN
export NNN_BMS="b:~/photos/Bilder/Canon EOS M50;c:~/.config;d:~/Downloads;m:~/stowfiles;p:~/programs;s:~/.local/bin;w:~/OneDrive - UiT Office 365/Skole"
export NNN_PLUG='d:diffs;f:fzcd;j:autojump;l:launch;p:preview-tui2;t:nmount;v:imgview'
BLK="34" CHR="c9" DIR="e6" EXE="64" REG="fa" HARDLINK="81" SYMLINK="d6" MISSING="f0" ORPHAN="00" FIFO="06" SOCK="00" OTHER="58"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_FIFO=/tmp/nnn.fifo nnn
export NNN_TRASH=1
# fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# cd on quit:
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


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# MY ALIASES
alias ls="lsd -FXA"
# alias rm="echo Do not use this, use trash-cli put filename instead"
alias rm="trash-put"
alias nv="nvim"
alias nnn="nnn -derH"
alias cat="bat"
alias sxiv="sxiv -b"
alias pqiv="pqiv -it"
alias yt="ytfzf"
alias publish_flottflyt="rsync -rtvzP --delete ~/projects/flottflyt/public/ root@flottflyt.xyz:/var/www/flottflyt"
alias publish_gallery_flottflyt="rsync -rtvzP ~/projects/gallery-flottflyt/photo-stream/_site/ root@flottflyt.xyz:/var/www/gallery-flottflyt"
alias publish_eirikenger="rsync -rtvzP ~/projects/eirikenger/ root@flottflyt.xyz:/var/www/eirikenger"
alias figlet="/Users/eirikenger/figlet/./figlet"
alias lolban="/Users/eirikenger/figlet/./lolban"
alias tks="tmux kill-session -t"

# Remarkable
alias saRM="ssh-keygen -R 10.11.99.1"
alias rmapi="~/./rmapi"
alias lsn="ls */ | less"

batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

cht() {
	# Cheat sheet for any command you can think of.
	curl cht.sh/$1
}

lc () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# Speedy keys
# xset r rate 210 40

# Zsh plugins and vi mode
source $HOME/programs/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh 2>/dev/null
zvm_after_init_commands+=('[ -f $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh ] && source $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh')
source $HOME/programs/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source $HOME/programs/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $HOME/programs/zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh 2>/dev/null
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# source $HOME/programs/zsh/git/.git-completion.bash
zstyle ':completion:*:*:git:*' script $HOME/programs/zsh/git/.git-completion.bash
fpath=(~/programs/zsh/git $fpath)

# export PATH="~/.pyenv/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# fi
source ~/.kb_alias

# forgit
source "$HOME/programs/forgit/forgit.plugin.zsh"

eval "$(starship init zsh)"
# eval "$(mcfly init zsh)"
# eval "$(pip completion --zsh)"
# eval "$(pass.zsh-completion)"

export PATH="/usr/local/opt/expat/bin:$PATH"
export HAS_ALLOW_UNSAFE=y

fpath+=~/.zfunc

# bun completions
[ -s "/Users/eirikenger/.bun/_bun" ] && source "/Users/eirikenger/.bun/_bun"

# bun
export BUN_INSTALL="/Users/eirikenger/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# deno
export DENO_INSTALL="/Users/eirikenger/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
