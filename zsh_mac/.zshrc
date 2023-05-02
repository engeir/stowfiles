# zmodload zsh/zprof  # Uncomment to run profiler (also last line)
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
# compinit  # Slows down the prompt. Just call it manually when in need
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

# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "Aloxaf/fzf-tab"
plug "MichaelAquilina/zsh-auto-notify"
plug "MichaelAquilina/zsh-you-should-use"
plug "jeffreytse/zsh-vi-mode"
plug "$HOME/.config/zsh/exports.zsh"
zvm_after_init_commands+=('[ -f $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh ] && source $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh')
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

plug /Users/eirikenger/.rvm/scripts/rvm

plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# Speedy keys
# xset r rate 210 40

# source $HOME/programs/zsh/git/.git-completion.bash
zstyle ':completion:*:*:git:*' script $HOME/programs/zsh/git/.git-completion.bash
fpath=(~/programs/zsh/git $fpath)

# export PATH="~/.pyenv/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# fi

# forgit
plug "$HOME/programs/forgit/forgit.plugin.zsh"

eval "$(starship init zsh)"
# eval "$(mcfly init zsh)"
# eval "$(pip completion --zsh)"
# eval "$(pass.zsh-completion)"

fpath+=~/.zfunc

# bun completions
[ -s "/Users/eirikenger/.bun/_bun" ] && plug "/Users/eirikenger/.bun/_bun"

eval "$(rtx activate zsh)"
eval "$(atuin init zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# zprof  # Uncomment to run profiler (also first line)
