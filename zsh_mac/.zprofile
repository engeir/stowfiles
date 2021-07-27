# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
# export PATH
PATH="/Users/eirikenger/Library/Python/3.7/bin:${PATH}"
export PATH
PATH="/usr/local/bin:${PATH}"
export PATH
PATH="/usr/bin:${PATH}"
export PATH
PATH="/Users/eirikenger/Documents/ReMarkableAPI:${PATH}"
export PATH

# NNN
export NNN_PLUG='j:autojump;f:fzcd;p:preview-tui;d:diffs;t:nmount;v:imgview' 

wgit() {
    wget https://github.com/engeir/$1/archive/master.zip
}

giit() {
    #do things with parameters like $1 such as
    git clone https://github.com/engeir/$1.git
}

py() {
    #do things with parameters like $1 such as
    python3 $1
}

gt() {
    # make a short cut for using Google translate
    cd ~; ./trans $1; cd -
}

skole() {
    cd ~/OneDrive\ -\ UiT\ Office\ 365/Skole/$1
}

function xman() { open x-man-page://$@ ; }

opn() {
    first="$(mdfind -name $1)"
    local res="$(echo $first | awk '{gsub(/ /,"\\ ");print}')"
    # local res=$(echo $first | perl -pe 's/ /\\ /g')
    # local res=$(echo $first | sed 's/ /\\ /g')
    code='$(open -- "$res")'
    eval "$code"
    # open -- "$res"
}

alias speed="speedtest-cli"
alias copen="code-insiders -n ."
alias trans="./trans"
export PATH="/usr/local/opt/flex/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
# added by Anaconda3 2019.10 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/opt/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
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

