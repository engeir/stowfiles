#!/usr/bin/env zsh

skip_global_compinit=1
ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/"
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

# bun completions
[ -s "/Users/eirikenger/.bun/_bun" ] && source "/Users/eirikenger/.bun/_bun"

# bun completions
[ -s "/home/een023/.bun/_bun" ] && source "/home/een023/.bun/_bun"
