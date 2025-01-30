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
zinit ice wait"2" as"command" from"gh-r" lucid \
  mv"zoxide*/zoxide -> zoxide" \
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light ryanccn/vivid-zsh  # Sets LS_COLORS
zi ice from'gh-r' as'program' sbin'**/eza -> eza' atclone'cp -vf completions/eza.zsh _eza'  # Install
zi light eza-community/eza
zi ice wait lucid has'eza' atinit'AUTOCD=1'  # Setup plugin
_EZA_PARAMS=(
  '--group-directories-first' '-a' '-F=always' '--icons' '--group'
  '--time-style=long-iso' '--color-scale=all' '--git'
)
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

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
eval "$(batpipe)"
eval "$(batman --export-env)"

if command -v coreutils 1>/dev/null 2>&1; then
    t1=$(coreutils date "+%s.%N")
    printf " Ready in %.3f seconds\n" $((t1 - t0))
fi

# zprof  # Uncomment to run profiler (also first line)
