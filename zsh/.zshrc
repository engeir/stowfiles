# Enable colors:
autoload -U colors && colors

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export TERM=screen-256color  # Needed for italics to work in tmux
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PAGER=less  # Suggested at https://github.com/jarun/nnn/wiki/Advanced-use-cases#pager-as-opener
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
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
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# eval "$(pip completion --zsh)"  # This slows down the prompt!
export PATH="$HOME/.poetry/bin:$PATH"

# Speedy keys
xset r rate 210 40

# Alias, functions and more
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
source ~/programs/command_line_apps/cdo-1.9.9/contrib/cdoCompletion.zsh 2>/dev/null

# fm6000 -r -c=random -n

# Change prompt:
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
xrdb ~/.config/Xresources
. "/home/een023/.local/share/lscolors.sh"

