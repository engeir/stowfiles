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
PATH="$HOME/Documents/ReMarkableAPI:${PATH}"

export PATH="/usr/local/opt/flex/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export GPG_TTY=$(tty)
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

if [[ $(uname) == "Linux" ]]; then
    # Make caps-lock work as esc when pressed, ctrl when hold
    setxkbmap -option ctrl:nocaps
    xcape -e 'Control_L=Escape'
fi

# Setting PATH for Python 3.8
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH

##
# Your previous /Users/eirikenger/.zprofile file was backed up as /Users/eirikenger/.zprofile.macports-saved_2020-06-06_at_11:28:14
##

# MacPorts Installer addition on 2020-06-06_at_11:28:14: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2021-01-11_at_20:53:58: adding an appropriate DISPLAY variable for use with MacPorts.
export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.
