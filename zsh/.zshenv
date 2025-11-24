#!/usr/bin/env zsh

skip_global_compinit=1
ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -s "$HOME/.bun/_bun" ] && . "$HOME/.bun/_bun"

[ -s "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
[ -s "$HOME/.local/share/bob/env/env.sh" ] && . "$HOME/.local/share/bob/env/env.sh"

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH
