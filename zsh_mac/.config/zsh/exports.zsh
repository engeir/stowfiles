export PATH="${PATH}:${HOME}/.local/bin"
# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$HOME/scripts:$HOME/.local/bin:$HOME/bin:$PATH
export NODE_PATH='/usr/local/lib/node_modules'
# export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/Users/eirikenger/Library/Python/3.9/bin:$PATH"
# export PATH=/usr/local/opt/ruby/bin:$PATH  # Ruby path
export PATH=/Applications/ConTeXtStandalone/tex/texmf-osx-64/bin:$PATH  # ConTeXt path

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL="alacritty"
export TERM=screen-256color  # Needed for italics to work in tmux
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PAGER=less  # Suggested at https://github.com/jarun/nnn/wiki/Advanced-use-cases#pager-as-opener
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESS='-Ri '
# export LS_COLORS="$(vivid generate nord)"
export LS_COLORS="$(vivid generate solarized-dark)"

# NNN
export NNN_BMS="b:~/photos/Bilder/Canon EOS M50;c:~/.config;d:~/Downloads;m:~/stowfiles;p:~/programs;s:~/.local/bin;w:~/OneDrive - UiT Office 365/Skole"
export NNN_PLUG='d:diffs;f:fzcd;j:autojump;l:launch;p:preview-tui2;t:nmount;v:imgview'
BLK="34" CHR="c9" DIR="e6" EXE="64" REG="fa" HARDLINK="81" SYMLINK="d6" MISSING="f0" ORPHAN="00" FIFO="06" SOCK="00" OTHER="58"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_FIFO=/tmp/nnn.fifo nnn
export NNN_TRASH=1
# fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PATH="/usr/local/opt/expat/bin:$PATH"
export HAS_ALLOW_UNSAFE=y

# bun
export BUN_INSTALL="/Users/eirikenger/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# deno
export DENO_INSTALL="/Users/eirikenger/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# bob
export PATH="$PATH:/Users/eirikenger/Library/Application Support/neovim/bin"
# auto-notify
export AUTO_NOTIFY_IGNORE=("docker" "man" "sleep" "lf" "nnn" "hugo serve" "fg" "ga")
# forgit
export FORGIT_FZF_DEFAULT_OPTS
