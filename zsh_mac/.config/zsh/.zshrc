#!/bin/zsh
if command -v coreutils 1>/dev/null 2>&1; then
    zmodload "zsh/zprof"  # Uncomment to run profiler (also last line)
    t0=$(coreutils date "+%s.%N")
fi
# Remove unexpected aliases
unalias -a
source "$HOME/.config/zsh/which-machine.zsh"

# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "zap-zsh/completions"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
# plug "zsh-users/zsh-history-substring-search"
plug "Aloxaf/fzf-tab"
plug "MichaelAquilina/zsh-auto-notify"
plug "MichaelAquilina/zsh-you-should-use"
plug "jeffreytse/zsh-vi-mode"
plug "chivalryq/git-alias"
plug "wfxr/forgit"
plug "conda-incubator/conda-zsh-completion"
plug "$HOME/.config/zsh/exports.zsh"
zvm_after_init_commands+=('[ -f $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh ] && source $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh')

plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/ssh.zsh"

# Search history for input with the up- and down-arrow
# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# Edit line in vim with ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# From https://github.com/MichaelAquilina/zshrc/blob/master/zshrc
export HISTSIZE="9999"
export SAVEHIST="9999"
export HISTFILESIZE="9999"
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt INTERACTIVE_COMMENTS
setopt PROMPT_CR

# Speedy keys
if [ "$MACHINE" = "Ubuntu" ]; then
    xset r rate 210 40
    xrdb "$HOME/.config/Xresources"
fi

# source $HOME/programs/zsh/git/.git-completion.bash
# zstyle ':completion:*:*:git:*' script $HOME/programs/zsh/git/.git-completion.bash
# fpath=(~/programs/zsh/git $fpath)

[ -s "$HOME/.bun/_bun" ] && plug "$HOME/.bun/_bun"
eval "$(thefuck --alias)"
eval "$(starship init zsh)"
eval "$(rtx activate zsh)"
eval "$(atuin init zsh)"
eval "$(atuin gen-completions --shell zsh --out-dir $HOME/.config/zsh/atuin_completion)"

# Completions sources
fpath+="${ZDOTDIR:-~}/.zsh_functions"  # This must come before compinit
fpath+="$HOME/.config/zsh/atuin_completion"
fpath+="$HOME/.local/share/zap/plugins/conda-zsh-completion/_conda"
if [ "$MACHINE" = "Ubuntu" ]; then
    autoload bashcompinit
    bashcompinit
    source "/usr/share/bash-completion/completions/pacstall"
    source "/usr/share/bash-completions/completions/cdo" 2>/dev/null
fi

if command -v coreutils 1>/dev/null 2>&1; then
    t1=$(coreutils date "+%s.%N")
    printf "Profile took %.3f seconds to load\n" $((t1-t0))
fi
# zprof  # Uncomment to run profiler (also first line)