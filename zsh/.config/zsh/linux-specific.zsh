#!/bin/zsh
# General
alias screenkey="screenkey --opacity 0.3 --bak-mode normal -M -f 'DejaVu Sans Mono Bold'"
alias tex2png="pnglatex -b Black -F White -d 2000"

# File handling
alias cp='/usr/local/bin/cpg -g'
alias lsn="ls --color=auto */ | less"
alias mv='/usr/local/bin/mvg -g'
alias lcc="lsblk -e 1,7"
alias open="xdg-open-awsm"
alias rg='rg -g "!Dropbox" -g "!OneDrive" -g "!BoxSync" -g "!.cache" -g "!.config/nnn" -g "!.git" -g "!node_module" -g "!.npm" -g "!.mozilla" -g "!.meteor" -g "!.nv" -g "!.conda" -g "!.dropbox-dist" -g "!.vscode" -g "!.vscode-insiders" -g "!miniconda3" -g "!.virtualenvs" -g "!snap" -g "!gems" -g "!.wine" -g "!extensions" -g "!coreutils-8.32" -g "!freetype-2.10.4" -g "!.cargo" -g "!Downloads" -g "!R" -g "!.Mathematica"'
alias skbat='sk --preview="bat {} --color=always"'
# alias f='cd ~ && cd $(fd --type d --type f --hidden --exclude .git --exclude .config/nnn --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv --exclude .conda --exclude .dropbox-dist --exclude .vscode --exclude .vscode-insiders --exclude miniconda3 --exclude .virtualenvs --exclude snap --exclude gems --exclude .wine --exclude extensions --exclude coreutils-8.32 --exclude freetype-2.10.4 --exclude .cargo --exclude Downloads --exclude R --exclude .Mathematica --exclude OneDrive --exclude BoxSync --exclude Dropbox | fzf)'

# reMarkable related
alias rmv="rmview ~/programs/rmview/rmview.json"
# alias rmapi="~/./rmapi"
# alias cptodo="cp ~/.kb/data/todo/pdh_work ~/Documents/notes_papers/_includes/todo.md"
alias saRM="ssh-add ~/rM_share"
alias skRM="ssh-keygen -R 10.11.99.1"
alias remouse="/home/een023/remousable_program/./remousable"

# More SSH
alias saVULTR="ssh-add ~/.ssh/id_vultr"

alias condainit=". ~/.config/zsh/condainit"

caps2esc() {
    # Make caps-lock work as esc when pressed, ctrl when hold
    setxkbmap -option ctrl:nocaps
    xcape -e 'Control_L=Escape'
}

pdf-reduce() {
    # From
    # https://askubuntu.com/questions/113544/how-can-i-reduce-the-file-size-of-a-scanned-pdf-file
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf "$1"
}

# File handling
p() {
    # this will open pdf file with the default PDF viewer on KDE, xfce, LXDE and
    # perhaps on other desktops.
    # open=zathura -
    # open=xdg-open
    # shellcheck disable=SC2016
    ag --ignore Dropbox --ignore OneDrive --ignore BoxSync -U -g ".pdf$" \
        | fast-p \
        | fzf --read0 --reverse -e -d $'\t' \
            --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|");
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
            ' \
        | cut -z -f 1 -d $'\t' | tr -d '\n' | xargs -r --null zathura - >/dev/null 2>/dev/null
}

fopen() {
    open "$(locate -i "$1")"
}

screen-record() {
    # From
    # https://www.reddit.com/r/archlinux/comments/artbxd/record_a_video_with_multi_monitors/
    read -r o g < <(slop -f '+%x,%y %wx%h')
    ffmpeg -f x11grab -framerate 60 -video_size "$g" -i "${DISPLAY}${o}" output.mkv
}
