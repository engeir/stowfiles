export PATH="${PATH}:${HOME}/.local/bin:$HOME/bin"
# If you come from bash you might have to change your $PATH.
# export PATH=/usr/local/bin:$HOME/scripts:$HOME/.local/bin:$HOME/bin:$PATH
export NODE_PATH='/usr/local/lib/node_modules'
# export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/Applications/ConTeXtStandalone/tex/texmf-osx-64/bin:$PATH"  # ConTeXt path
export PATH="$PATH:$HOME/.cabal/bin/"
# Go
# This is weird, but it works...
export GOROOT="/usr/local/go"  # Moved to Mac specific
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$GOROOT/bin"

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL="alacritty"
export TERM=screen-256color  # Needed for italics to work in tmux
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PAGER=less  # Suggested at https://github.com/jarun/nnn/wiki/Advanced-use-cases#pager-as-opener
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_PAGER="less -R"
export LESS='-Ri '
export LS_COLORS="$(vivid generate solarized-dark)"

# NNN
export NNN_USE_EDITOR=1
export USE_VIDEOTHUMB=1
BLK="34" CHR="c9" DIR="e6" EXE="64" REG="fa" HARDLINK="81" SYMLINK="d6" MISSING="f0" ORPHAN="00" FIFO="06" SOCK="00" OTHER="58"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_FIFO=/tmp/nnn.fifo nnn
export NNN_TRASH=1
export NNN_TERMINAL="wezterm"
if [ "$MACHINE" = "Darwin" ]; then
    plug "$HOME/.config/zsh/mac-specific.zsh"
fi
if [ "$MACHINE" = "Ubuntu" ]; then
    plug "$HOME/.config/zsh/linux-specific.zsh"
fi

# FZF settings
export FZF_BASE=/usr/bin
# export DISABLE_FZF_AUTO_COMPLETION="true"
# export FZF_DEFAULT_OPTS="--no-mouse --layout=reverse --height 100% -1 --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
# export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type 1 $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
export FZF_DEFAULT_COMMAND='fd --type f -I'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PATH="/usr/local/opt/expat/bin:$PATH"
export HAS_ALLOW_UNSAFE=y

# auto-notify
export AUTO_NOTIFY_IGNORE=("nv" "docker" "man" "sleep" "lf" "nnn" "hugo serve" "fg" "ga")
# bob
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
# mason bin installation
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# dprint
export DPRINT_INSTALL="$HOME/.local/bin/"
# emacs
export PATH="$PATH:$HOME/.config/emacs/bin"
# forgit
export FORGIT_FZF_DEFAULT_OPTS
# rush
export RUSH_CONFIG="$HOME/.config/rush/rush.ini"
# ruby / gem
# export PATH=/usr/local/opt/ruby/bin:$PATH  # Ruby path
export PATH="$PATH:/home/een023/.gem/ruby/3.0.0/bin"
# rye
export RYE_HOME="$HOME/.local/share/rye/"
export PATH="$PATH:$RYE_HOME/shims/"

# wezterm complains about
# ERROR: ld.so: object 'libgtk3-nocsd.so.0' from LD_PRELOAD cannot be preloaded (failed to map segment from shared object): ignored.
# See https://stackoverflow.com/a/53825858
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0
