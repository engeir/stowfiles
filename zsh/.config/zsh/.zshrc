#!/bin/zsh

if command -v coreutils 1>/dev/null 2>&1; then
    # zmodload "zsh/zprof" # Uncomment to run profiler (also last line)
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
zinit wait"0" lucid for \
    OMZP::git \
    OMZP::archlinux \
    OMZP::command-not-found
zinit snippet OMZP::ssh

zinit light Aloxaf/fzf-tab

zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship
autoload -Uz add-zsh-hook
add-zsh-hook precmd transient-prompt-precmd
TRANSIENT_PROMPT="${PROMPT// prompt / prompt --profile transient }"
TRANSIENT_RPROMPT="${PROMPT// prompt / prompt --profile rtransient }"
function transient-prompt-precmd {
    # Fix ctrl+c behavior
    TRAPINT() { transient-prompt; return $(( 128 + $1 )) }
    # Save transient prompt
    SAVED_PROMPT="$(eval "printf '%s' \"${TRANSIENT_PROMPT}\"")"
    SAVED_RPROMPT="$(eval "printf '%s' \"${TRANSIENT_RPROMPT}\"")"
}
autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-finish transient-prompt
function transient-prompt() {
    # Use saved transient prompt
    PROMPT="$SAVED_PROMPT" RPROMPT="$SAVED_RPROMPT" zle .reset-prompt
}

zinit ice wait"2" as"command" from"gh-r" lucid \
  mv"zoxide*/zoxide -> zoxide" \
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit ice wait"0" lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait"0" lucid; zinit light ryanccn/vivid-zsh  # Sets LS_COLORS
zinit ice from'gh-r' as'program' sbin'**/eza -> eza' atclone'cp -vf completions/eza.zsh _eza'  # Install
zinit light eza-community/eza
zinit ice wait lucid has'eza' atinit'AUTOCD=1' atload'unalias lx llm' # Setup plugin
_EZA_PARAMS=(
  '--group-directories-first' '-a' '-F=always' '--icons' '--group' '--octal-permissions'
  '--time-style=long-iso' '--color-scale=all' '--git' '--mounts'
)
zinit light z-shell/zsh-eza
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit wait"0" lucid for \
    MichaelAquilina/zsh-auto-notify \
    MichaelAquilina/zsh-you-should-use \
    wfxr/forgit
# This is overridden by atuin in insert mode, but takes precedence in vi/normal mode.
zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload'_history_substring_search_config'
# atuin
zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin

fpath+="${ZDOTDIR:-~}/.zsh_functions"
autoload -Uz compinit
() {
    local _dump="${ZDOTDIR:-~}/.zcompdump"
    local _zinit_comp="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/completions"
    if [[ ! -f "$_dump" ]] || (( $(date +%s) - $(stat -c %Y "$_dump") > 86400 )); then
        # Full rebuild: first clean dead symlinks that cause compinit errors
        [[ -d "$_zinit_comp" ]] && for _f in "$_zinit_comp"/_*(N@); do
            [[ -e "$_f" ]] || rm -f "$_f"
        done
        compinit
    else
        compinit -C
    fi
}
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

# Some default suffix aliases
alias -s md='bat'
alias -s json='jless'
alias -s yaml='bat -l yaml'
alias -s md="$EDITOR"
# Global aliases
alias -g NUL='> /dev/null 2>&1'
alias -g NE='2> /dev/null'
alias -g DN='> /dev/null'
bindkey -s '^Xgc' 'git commit -m ""\C-b'

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
# No preview by default
zstyle ':fzf-tab:complete:*' fzf-preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# GPG agent for SSH - configured in ~/.gnupg/gpg-agent.conf
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

# Source some other configs
. "$HOME/.config/zsh/functions.zsh"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Shell integrations — cached to avoid subprocess overhead on every start
() {
    local _dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
    mkdir -p "$_dir"

    _zi() {
        local cache="$_dir/$1.zsh" bin="${commands[$2]:-}"
        shift 2
        [[ ! -f "$cache" || ( -n "$bin" && "$bin" -nt "$cache" ) ]] && "$@" >| "$cache"
        builtin source "$cache"
    }

    _zi mise        mise        mise activate zsh
    _zi pitchfork   pitchfork   pitchfork activate zsh
    _zi fnox        mise        mise x -- fnox activate zsh
    _zi fzf         fzf         fzf --zsh
    _zi zoxide      zoxide      zoxide init --cmd cd zsh
    _zi atuin       atuin       atuin init zsh
    _zi batpipe     batpipe     batpipe
    _zi batman      batman      batman --export-env
    _zi navi        navi        navi widget zsh

    unfunction _zi
}
# Atuin needs a unique session ID per shell (not the cached one)
export ATUIN_SESSION="$(</proc/sys/kernel/random/uuid)"

if command -v coreutils 1>/dev/null 2>&1; then
    t1=$(coreutils date "+%s.%N")
    printf " Ready in %.3f seconds\n" $((t1 - t0))
fi

# zprof  # Uncomment to run profiler (also first line)
