#!/bin/sh
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ "$BASH_VERSION" != "" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi
export GPG_TTY=$(tty)

# export PATH=$HOME/.config/rofi/bin:$PATH
# export GH_PAT_POLYBAR=$(pass API/polybar_github)

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Start keychain
# if [[ -d "/home/een023/" ]]; then
if command -v /usr/bin/keychain >/dev/null 2>&1; then
    if uname -a | grep -i ubuntu >/dev/null 2>&1; then
        "$HOME/bin/start-keychain-expect"
    elif uname -a | grep -i arch >/dev/null 2>&1; then
        "$HOME/bin/start-keychain-arch-expect"
    fi
fi
# export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0
# fi
xset r rate 210 70
xrdb "$HOME/.config/Xresources"

# Config for fzf
# FD_OPTIONS="--follow --exclude .git --exclude node_modules"

# export BAT_PAGER="less -R"
# if [[ $(uname) == "Linux" ]]; then
#     sh /home/een023/stowfiles/bspwm/.config/bspwm/bin/bspcomp &
#     if [ -e /home/een023/.nix-profile/etc/profile.d/nix.sh ]; then . /home/een023/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
# fi

gen_comps() {
    if command -v "$1" >/dev/null; then
        eval "$1 $2" >"$HOME/.config/zsh/.zsh_functions/_$3"
        eval "$(cat "$HOME/.config/zsh/.zsh_functions/_$3")"
    fi
}

# . "$HOME/.cargo/env"
. "$HOME/.local/share/rye/env"
export PATH="$HOME/.local/share/zinit/plugins/atuinsh---atuin:$PATH"
eval "$("$HOME/.local/bin/mise" activate zsh)"
mkdir -p "$HOME/.config/zsh/.zsh_functions"
gen_comps mise "completion zsh" "mise"
gen_comps aqua "completion zsh" "aqua"
gen_comps atuin "gen-completions --shell zsh" "atuin"
gen_comps bw "completion --shell zsh" "bitwarden"
gen_comps just "--completions zsh" "just"
gen_comps pixi "completion --shell zsh" "pixi"
gen_comps uv "generate-shell-completion zsh" "uv"
