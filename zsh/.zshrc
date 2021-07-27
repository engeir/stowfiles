# Enable colors:
autoload -U colors && colors

export EDITOR="nvim"
export VISUAL="nvim"
export TERM=screen-256color  # Needed for italics to work in tmux
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

# For golang
GOROOT=/usr/local/go
GOPATH=~/.go
CABALPATH=~/.cabal
PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$CABALPATH/bin

# Config for nnn
export NNN_USE_EDITOR=1
export NNN_PLUG='a:bookmarks;b:bibfinder;c:diffs;d:dragdrop;f:fzcd;i:ipinfo;m:viewmedia;o:organize;p:preview-tui2;r:rm-send;u:upgrade'
# export NNN_PLUG='a:bookmarks;b:bibfinder;c:diffs;d:dragdrop;f:fzcd;i:ipinfo;m:viewmedia;o:organize;p:my_preview;r:rm-send;u:upgrade'
export NNN_BMS='b:~/BoxSync/;c:~/.config/;d:~/Downloads/;l:~/.local;n:~/Documents/notes_papers/;m:~/stowfiles/;o:~/OneDrive/;p:~/programs/;r:~/science/ref/;s:~/bin/;t:~/Documents/teaching/;w:~/Documents/work/'
BLK="34" CHR="c9" DIR="e6" EXE="64" REG="fa" HARDLINK="81" SYMLINK="d6" MISSING="f0" ORPHAN="00" FIFO="06" SOCK="00" OTHER="58"
# export NNN_FCOLORS='34c9E664fa81d6f000000058'
# BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
alias nnn="nnn -derH"
export NNN_FIFO=/tmp/nnn.fifo nnn
# export PAGER="less -R"
export PAGER=less  # Suggested at https://github.com/jarun/nnn/wiki/Advanced-use-cases#pager-as-opener
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
[ -r "$HOME/bin/lesspipe.sh" ] && export LESSOPEN="| $HOME/bin/lesspipe.sh %s"
export LESS='-Ri '
# export NNN_CACHE=/tmp/nnn.fifo nnn
# export NNN_OPENER=/home/een023/.config/nnn/plugins/nuke
export USE_VIDEOTHUMB=1
export NNN_TRASH=1
fpath+=${ZDOTDIR:-~}/.zsh_functions  # This must come before compinit
fpath+=/home/een023/programs/zsh/conda-zsh-completion

# Config for fzf
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
FD_CTRL_T_OPTIONS="--type d --type f --hidden --exclude .git --exclude .config/nnn --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv --exclude .conda --exclude .dropbox-dist --exclude .vscode --exclude .vscode-insiders --exclude miniconda3 --exclude .virtualenvs --exclude snap --exclude gems --exclude .wine --exclude extensions --exclude coreutils-8.32 --exclude freetype-2.10.4 --exclude .cargo --exclude Downloads --exclude R --exclude .Mathematica --exclude OneDrive --exclude BoxSync --exclude Dropbox"
# FZF settings
export FZF_BASE=/usr/bin
# export DISABLE_FZF_AUTO_COMPLETION="true"
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
# export FZF_DEFAULT_OPTS="--no-mouse --layout=reverse --height 100% -1 --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(batcat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
# export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fdfind --type f --type 1 $FD_OPTIONS"
export FZF_DEFAULT_COMMAND="fdfind --exclude __pycache__"
export FZF_CTRL_T_COMMAND="fdfind $FD_CTRL_T_OPTIONS"
export FZF_ALT_C_COMMAND="fdfind --type d $FD_OPTIONS"
# _fzf_compgen_path() {
# 	fdfind --hidden --follow --exclude ".git" . "$1"
#   }

export BAT_PAGER="less -R"

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/een023/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
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

# Change cursor for vi modes:
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# bindkey -s '^o' 'ofzf^M'
bindkey -s '^o' 'tmux-nnn^M'

# Search history for input with the up- and down-arrow
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Config for pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# Virtualenvwrapper settings:
export WORKON_HOME=$HOME/.virtualenvs

export PATH="$HOME/.poetry/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
 eval "$(pyenv virtualenv-init -)"
fi

VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
. ~/.local/bin/virtualenvwrapper.sh

# Autocomplete for cdo
source ~/programs/command_line_apps/cdo-1.9.9/contrib/cdoCompletion.zsh 2>/dev/null

# Replace the normal tab-behavior with fzf
source ~/programs/zsh/fzf-tab/fzf-tab.plugin.zsh

# User configuration fzf
# source ~/bin/key-bindings.zsh 2>/dev/null
source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null
source /usr/share/doc/fzf/examples/completion.zsh 2>/dev/null

# Alias and functions
source ~/.config/.aliasrc
source ~/.config/.functionsrc
source ~/.config/.kb_alias

# Change prompt:
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
eval "$(starship init zsh)"
eval "$(jump shell zsh)"
eval "$(thefuck --alias)"
xrdb ~/.config/Xresources
. "/home/een023/.local/share/lscolors.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/een023/programs/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/een023/programs/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/een023/programs/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/een023/programs/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Improved vi mode
# ZVM_VI_SURROUND_BINDKEY=s-prefix
source /home/een023/programs/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh 2>/dev/null
# zvm_after_init_commands+=('[ -f ~/bin/key-bindings.zsh ] && source ~/bin/key-bindings.zsh')
zvm_after_init_commands+=('[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh')
# Load autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# Load the syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

fm6000 -r -c=random -n

source /home/een023/.config/broot/launcher/bash/br
