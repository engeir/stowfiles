#!/bin/zsh
# MY ALIASES
alias history="fc -li 1"
# alias ls="lsd -FXA"
alias ls="exa --icons -Fa --group-directories-first"
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
