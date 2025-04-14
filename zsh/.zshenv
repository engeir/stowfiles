#!/usr/bin/env zsh

skip_global_compinit=1
ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -s "$HOME/.bun/_bun" ] && . "$HOME/.bun/_bun"

[ -s "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
