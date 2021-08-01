# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/scripts:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/eirikenger/.oh-my-zsh"
export VISUAL=nvim
export EDITOR=nvim
# Bat is better at showing man-pages as well
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"
# Fav:
    # mortalscumbag
    # suvash
    # ys
    # passion
# af-magic
# amuse
# avit
# bureau
# robbyrussell
# mortalscumbag
# muse
# sunrise
# suvash
# ys
# passion

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    osx
    git
    python
    poetry
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

#Virtualenvwrapper settings:
export WORKON_HOME=$HOME/.virtualenvs
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
. /usr/local/bin/virtualenvwrapper.sh

# export MANPATH="/usr/local/man:$MANPATH"

# NNN
export NNN_BMS="b:~/OneDrive - UiT Office 365/Bilder/Canon EOS M50;c:~/.config;d:~/Downloads;m:~/stowfiles;p:~/programs;s:~/.local/bin;w:~/OneDrive - UiT Office 365/Skole"
export NNN_PLUG='d:diffs;f:fzcd;j:autojump;l:launch;p:preview-tui;t:nmount;v:imgview' 
export NNN_FIFO=/tmp/nnn.fifo nnn
export NNN_TRASH=1
# cd on quit:
nn ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -deH "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# MY ALIASES
alias rm="echo Do not use this, use trash-cli put filename instead"
alias nv="nvim"
alias nnn="nnn -derH"
alias cat="bat"
alias sxiv="sxiv -b"
alias pqiv="pqiv -it"
alias yt="ytfzf"
alias figlet="/Users/eirikenger/figlet/./figlet"
alias lolban="/Users/eirikenger/figlet/./lolban"
koolcat() {
	echo "$@" | figlet | lolcat
}

# Remarkable
alias saRM="ssh-keygen -R 10.11.99.1"
alias rmapi="~/./rmapi"
alias lsn="ls */ | less"

batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

cht() {
	# Cheat sheet for any command you can think of.
	curl cht.sh/$1
}

# Files functions
cdd() {
	cd "$(mdfind -name $1)"
}

lc () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# Helper functions
wgit() {
    wget https://github.com/engeir/$1/archive/master.zip
}

yr() {
    loc=${1:-tromsø}
    curl wttr.in/$loc
}


export PATH="~/.pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
source ~/.kb_alias

eval "$(starship init zsh)"
eval "$(mcfly init zsh)"

export PATH="/usr/local/opt/expat/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
fm6000 -c=random -n
