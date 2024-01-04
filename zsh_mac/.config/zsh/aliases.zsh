#!/bin/zsh
alias history="fc -li 1"

# MY ALIASES

alias _="sudo"
alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'
alias c="calcurse"
alias cat="bat"
alias has="HAS_ALLOW_UNSAFE=y has"
alias lg="lazygit"
alias ll="eza --icons -Fal --group-directories-first"
alias ls="eza --icons -Fa --group-directories-first"
alias n.="nvim ."
alias nnn="nnn -derH"
alias nv="nvim"
alias nvl="NVIM_APPNAME=LazyNvim nvim"
alias rm="trash-put"
alias todo='calcurse -t --format-todo "(%p) %m\n%N" | grep -v "No note file found"'
alias yt="ytfzf -t"

# It's nice with habits
alias :q="exit"
alias :wq="exit"
alias ZZ="exit"
alias ZQ="exit"

# Git
alias gin="git --no-pager"
alias gip="git push -u origin main"
alias gpull="git pull --ff-only"
alias saGITHUB="ssh-add ~/.ssh/id_github"
unalias gup

if [ "$MACHINE" = "Darwin" ]; then
    plug "$HOME/.config/zsh/mac-specific.zsh"
fi
if [ "$MACHINE" = "Ubuntu" ]; then
    plug "$HOME/.config/zsh/linux-specific.zsh"
fi

# alias ls="lsd -FXA"
# alias rm="echo Do not use this, use trash-cli put filename instead"
# alias pqiv="pqiv -it"
