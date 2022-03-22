# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export VISUAL="nvim"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="st"
# export ZDOTDIR="$HOME/.config/zsh"
export PATH=$PATH:/usr/local/go/bin:/home/een023/go/bin:/home/een023/.cargo/bin
export PATH=$HOME/.config/rofi/bin:$PATH
export FZF_COMPLETION_TRIGGER='\\'
export GH_PAT_POLYBAR=$(pass API/polybar_github)
export WTF_GITHUB_TOKEN=$(pass API/wtf_github)
export WTF_GITHUB_BASE_URL="https://github.com/engeir"
export AFTERSHIP_API_KEY=$(pass API/aftership)
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

# export BAT_PAGER="less -R"

# Created by `pipx` on 2021-10-25 10:32:18
export PATH="$PATH:/home/een023/.local/bin"

# Make caps-lock work as esc when pressed, ctrl when hold
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'
