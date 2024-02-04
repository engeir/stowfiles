function condainit --description "Initialize conda"
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if test -f /home/een023/programs/miniconda3/bin/conda
        eval /home/een023/programs/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    end
    # <<< conda initialize <<<
end
