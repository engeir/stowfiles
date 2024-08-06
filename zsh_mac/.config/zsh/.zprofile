# WARNING: this file is not run (I'm quite sure)

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Set XDG stuff
# export $XDG_CONFIG_HOME="$HOME/.config"
# export XDG_DATA_HOME="$HOME/.local/share"
# export $XDG_STATE_HOME="$HOME/.local/state"
# export $XDG_CACHE_HOME="$HOME/.cache"
# export $XDG_RUNTIME_DIR="/run/user/$UID"

export PATH="${PATH}:${HOME}/.local/bin"

PATH="/usr/local/bin:${PATH}"
PATH="/usr/bin:${PATH}"
export PATH="/usr/local/opt/flex/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
GPG_TTY=$(tty)
export GPG_TTY
export PATH="/usr/local/bin:$PATH"
