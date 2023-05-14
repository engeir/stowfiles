#!/bin/zsh
if command -v coreutils 1>/dev/null 2>&1; then
    zmodload "zsh/zprof"
    t0=$(coreutils date "+%s.%N")
fi
# Enable colors:
autoload -U colors && colors

# /usr/bin/keychain --lockwait 0 --clear $HOME/.ssh/id_rsa
# echo $HOME/.keychain/$HOSTNAME-sh

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export TERM=screen-256color  # Needed for italics to work in tmux
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PAGER=less  # Suggested at https://github.com/jarun/nnn/wiki/Advanced-use-cases#pager-as-opener
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESS='-Ri '

# For golang
GOROOT=/usr/local/go
GOPATH=~/.go
CABALPATH=~/.cabal
PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$CABALPATH/bin

fpath+=${ZDOTDIR:-~}/.zsh_functions  # This must come before compinit
fpath+=/home/een023/programs/zsh/conda-zsh-completion

export BAT_PAGER="less -R"

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
# compinit  # Slows down the prompt. Just call it manually when in need
_comp_options+=(globdots)  # Includes hidden files
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.histfile
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

# Config for pyenv and pip (slows down the prompt, move to aliasrc)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# eval "$(pip completion --zsh)"  # This slows down the prompt!

# Speedy keys
xset r rate 210 40

# Alias, functions and more
source ~/.config/zsh/exports.zsh
source ~/.config/zsh/aliasrc
source ~/.config/zsh/functionsrc
source ~/.config/zsh/kb_alias
source ~/.config/zsh/fzfrc
source ~/.config/zsh/nnnrc
autoload bashcompinit
bashcompinit
source /usr/share/bash-completion/completions/pacstall
# ZVM_VI_SURROUND_BINDKEY=s-prefix
source /home/een023/programs/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh 2>/dev/null
zvm_after_init_commands+=('[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh')
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# source /home/een023/.config/broot/launcher/bash/br
if [ -e /home/een023/.nix-profile/etc/profile.d/nix.sh ]; then . /home/een023/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
source "/usr/share/bash-completions/completions/cdo" 2>/dev/null

# forgit
source "$HOME/programs/forgit/forgit.plugin.zsh"

# for tabby to recognize where I am
precmd () { echo -n "\x1b]1337;CurrentDir=$(pwd)\x07" }

# Change prompt:
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
xrdb ~/.config/Xresources
. "/home/een023/.local/share/lscolors.sh"

# Created by `pipx` on 2021-10-25 10:32:18
export PATH="$PATH:/home/een023/.local/bin"

# setup ssh-agent
SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

eval "$(atuin init zsh)"
eval "$(atuin gen-completions --shell zsh --out-dir $HOME/.config/zsh/atuin_completion)"
fpath+="$HOME"/.config/zsh/atuin_completion
export GPG_TTY=$(tty)

# This takes a moment to load (0.4-0.5 seconds), can be annoying
# bun completions
# [ -s "/home/een023/.bun/_bun" ] && source "/home/een023/.bun/_bun"

# bun
export BUN_INSTALL="/home/een023/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bob
export PATH="/home/een023/.local/share/bob/nvim-bin:$PATH"

# rtx
eval "$(rtx activate zsh)"

if command -v coreutils 1>/dev/null 2>&1; then
    t1=$(coreutils date "+%s.%N")
    printf "Profile took %.3f seconds to load\n" $((t1-t0))
fi
