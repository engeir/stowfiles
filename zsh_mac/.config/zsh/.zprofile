export PATH="${PATH}:${HOME}/.local/bin"

PATH="/usr/local/bin:${PATH}"
PATH="/usr/bin:${PATH}"
PATH="/Users/eirikenger/Documents/ReMarkableAPI:${PATH}"
export PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# NNN
export NNN_PLUG='j:autojump;f:fzcd;p:preview-tui;d:diffs;t:nmount;v:imgview' 

function xman() { open x-man-page://$@ ; }

export PATH="/usr/local/opt/flex/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export GPG_TTY=$(tty)
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"


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
eval "$(pyenv init --path)"
