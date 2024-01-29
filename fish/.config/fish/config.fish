if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    atuin init fish | source
    mise activate fish | source
    set -g fish_key_bindings fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual line
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/een023/programs/miniconda3/bin/conda
    eval /home/een023/programs/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<
