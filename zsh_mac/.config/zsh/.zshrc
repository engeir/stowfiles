#!/bin/zsh

if command -v coreutils 1>/dev/null 2>&1; then
    zmodload "zsh/zprof" # Uncomment to run profiler (also last line)
    t0=$(coreutils date "+%s.%N")
fi
unalias -a

# Paths (set with mise)
export DISPLAY=:0
vivid_theme="jellybeans"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::ssh

zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light ryanccn/vivid-zsh  # Sets LS_COLORS
zi ice wait lucid has'eza' atinit'AUTOCD=1'
zi light z-shell/zsh-eza
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light MichaelAquilina/zsh-auto-notify
zinit light MichaelAquilina/zsh-you-should-use
zinit light wfxr/forgit
zinit light wintermi/zsh-mise
# zinit light olets/zsh-abbr
# This is overridden by atuin in insert mode, but takes precedence in vi/normal mode.
zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload'_history_substring_search_config'
# atuin
zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin

fpath+="${ZDOTDIR:-~}/.zsh_functions" # This must come before compinit
autoload -Uz compinit
# From https://gist.github.com/ctechols/ca1035271ad134841284?permalink_comment_id=4624611#gistcomment-4624611
# [ ! "$(find "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/.zcompdump -mtime 1)" ] || compinit
# compinit -C
compinit

zinit cdreplay -q

# Keybindings
bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
autoload edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down
bindkey '^ ' autosuggest-accept

# History
# From
#  https://github.com/MichaelAquilina/zshrc/blob/master/zshrc
#  https://github.com/dreamsofautonomy/zensh
HISTSIZE="9999"
HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/.zsh_history"
SAVEHIST="$HISTSIZE"
HISTDUP=erase
setopt appendhistory
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt sharehistory
# setopt INC_APPEND_HISTORY_TIME
# setopt INTERACTIVE_COMMENTS
# setopt PROMPT_CR

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

# Source some other configs
. "$HOME/.config/zsh/functions.zsh"
if [ "$MACHINE" = "ubuntu" ]; then
    # . "$HOME/.config/zsh/ssh.zsh"
    "$HOME/bin/start-agent-expect"
    . "$HOME/.local/share/rye/env"
    xset r rate 210 40
    xrdb "$HOME/.config/Xresources"
if [ "$MACHINE" = "arch" ]; then
    "$HOME/bin/start-keychain-arch-expect"
    . "$HOME/.local/share/rye/env"
fi

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
eval "$(atuin gen-completions --shell zsh --out-dir "$HOME"/.config/zsh/atuin_completion)"
# eval "$(bw completion --shell zsh >"$HOME/.config/zsh/.zsh_functions/_bitwarden")"
eval "$(batpipe)"

# OLD ----------------------------------------------------------------------------------

# # Remove unexpected aliases
# unalias -a
# source "$HOME/.config/zsh/which-machine.zsh"
#
# plug "olets/zsh-abbr"
# plug "Aloxaf/fzf-tab"
# plug "MichaelAquilina/zsh-auto-notify"
# plug "MichaelAquilina/zsh-you-should-use"
# plug "jeffreytse/zsh-vi-mode"
# plug "chivalryq/git-alias"
# plug "wfxr/forgit"
# plug "conda-incubator/conda-zsh-completion"
# plug "$HOME/.config/zsh/exports.zsh"
# zvm_after_init_commands+=('[ -f $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh ] && source $HOME/programs/zsh/fzf-key-bindings/key-bindings.zsh')
#
# # Let's try this while we are using olets/zsh-abbr
#
# # Search history for input with the up- and down-arrow
# # bindkey "^[[A" history-beginning-search-backward
# # bindkey "^[[B" history-beginning-search-forward
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
# # Edit line in vim with ctrl-v
# autoload edit-command-line
# zle -N edit-command-line
# bindkey '^v' edit-command-line
#
#
# # source $HOME/programs/zsh/git/.git-completion.bash
# # zstyle ':completion:*:*:git:*' script $HOME/programs/zsh/git/.git-completion.bash
# # fpath=(~/programs/zsh/git $fpath)
#
# [ -s "$HOME/.bun/_bun" ] && plug "$HOME/.bun/_bun"
# # eval "$(thefuck --alias)"
# eval "$(starship init zsh)"
#
# # Completions sources
# fpath+="${ZDOTDIR:-~}/.zsh_functions" # This must come before compinit
# fpath+="$HOME/.config/zsh/atuin_completion"
# fpath+="$HOME/.local/share/zap/plugins/conda-zsh-completion/_conda"
# if [ "$MACHINE" = "Ubuntu" ]; then
#     autoload bashcompinit
#     bashcompinit
#     source "/usr/share/bash-completion/completions/pacstall"
#     source "/usr/share/bash-completions/completions/cdo" 2>/dev/null
#
#     declare -A pomo_options
#     pomo_options["work"]="45"
#     pomo_options["break"]="10"
#     pomodoro() {
#         val=$1
#         clear
#         echo "$val" | lolcat
#         timer "${pomo_options["$val"]}"m
#         spd-say "'$val' session done"
#         notify-send --app-name=Pomodoro🍅 "'$val' session done 🍅"
#     }
#     start_pomodoro() {
#         # Number of times to repeat the loop, default is 2
#         if [ "$1" != "" ] && [ "$1" -eq "$1" ] 2>/dev/null; then
#             num_loops=$1
#         else
#             # Default loops
#             num_loops=2
#         fi
#
#         for ((n = 0; n < num_loops; n++)); do
#             pomodoro "work"
#             pomodoro "break"
#         done
#     }
#     change_pomo() {
#         if [ "$1" != "" ] && [ "$2" != "" ]; then
#             pomo_options["$1"]="$2"
#             echo "The $1 time has been changed to $2 minutes"
#         else
#             echo "Please provide valid parameters: change_pomo [work/break] [time_in_minutes]"
#         fi
#     }
#     alias doro=start_pomodoro
#     alias wo="pomodoro 'work'"
#     alias br="pomodoro 'break'"
#     alias doronew=change_pomo
# fi

if command -v coreutils 1>/dev/null 2>&1; then
    t1=$(coreutils date "+%s.%N")
    printf " Ready in %.3f seconds\n" $((t1 - t0))
fi

# zprof  # Uncomment to run profiler (also first line)
