if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    fzf --fish | source
    atuin init fish | source
    mise activate fish | source
    zoxide init fish | source
    source ~/.config/fish/conf.d/forgit.plugin.fish
    set -g fish_key_bindings fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual line
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Wasmer
export WASMER_DIR="/Users/eirikenger/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
