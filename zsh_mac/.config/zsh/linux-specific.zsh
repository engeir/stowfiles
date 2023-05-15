#!/bin/zsh
# General
alias screenkey="screenkey --opacity 0.3 --bak-mode normal -M -f 'DejaVu Sans Mono Bold'"
alias wezterm='flatpak run org.wezfurlong.wezterm'
alias tex2png="pnglatex -b Black -F White -d 2000"

# Update file indexing
alias u="sudo updatedb"
alias dropbox_update="~/.dropbox-dist/dropboxd"

# File handling
alias skbat='sk --preview="bat {} --color=always"'
alias rg='rg -g "!Dropbox" -g "!OneDrive" -g "!BoxSync" -g "!.cache" -g "!.config/nnn" -g "!.git" -g "!node_module" -g "!.npm" -g "!.mozilla" -g "!.meteor" -g "!.nv" -g "!.conda" -g "!.dropbox-dist" -g "!.vscode" -g "!.vscode-insiders" -g "!miniconda3" -g "!.virtualenvs" -g "!snap" -g "!gems" -g "!.wine" -g "!extensions" -g "!coreutils-8.32" -g "!freetype-2.10.4" -g "!.cargo" -g "!Downloads" -g "!R" -g "!.Mathematica"'
alias cp='/usr/local/bin/cpg -g'
alias mv='/usr/local/bin/mvg -g'
# alias f='cd ~ && cd $(fd --type d --type f --hidden --exclude .git --exclude .config/nnn --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv --exclude .conda --exclude .dropbox-dist --exclude .vscode --exclude .vscode-insiders --exclude miniconda3 --exclude .virtualenvs --exclude snap --exclude gems --exclude .wine --exclude extensions --exclude coreutils-8.32 --exclude freetype-2.10.4 --exclude .cargo --exclude Downloads --exclude R --exclude .Mathematica --exclude OneDrive --exclude BoxSync --exclude Dropbox | fzf)'
alias ll="ls -ltrh"
alias lsn="ls --color=auto */ | less"
alias open="xdg-open"

# Open programs
alias nikkerud="~/betty/main.rb"
alias nvb="nvim ~/.local/share/bookmarks/bookmarks.sh"
alias vpn="/opt/cisco/anyconnect/bin/vpnui"

# reMarkable related
alias rmv="rmview ~/programs/rmview/rmview.json"
# alias rmapi="~/./rmapi"
# alias cptodo="cp ~/.kb/data/todo/pdh_work ~/Documents/notes_papers/_includes/todo.md"
alias saRM="ssh-add ~/rM_share"
alias skRM="ssh-keygen -R 10.11.99.1"
alias remouse="/home/een023/remousable_program/./remousable"

# FRAM
alias sfram="ssh -X -Y een023@fram.sigma2.no"
alias saFRAM="ssh-add ~/.ssh/id_sigma2"
alias cpfram="cp ~/.kb/data/cheatsheet/fram ~/Documents/notes_papers/_includes/fram_cheat.md"

# More SSH
alias saVULTR="ssh-add ~/.ssh/id_vultr"

alias condainit=". ~/.config/zsh/condainit"

export NNN_PLUG='a:bookmarks;b:bibfinder;c:diffs;d:dragdrop;f:fzcd;i:ipinfo;j:autojump;m:viewmedia;o:organize;p:preview-tui;r:rm-send;s:fzplug;u:upload'
export NNN_BMS='b:~/Pictures/;c:~/.config/;d:~/Downloads/;l:~/.local;n:~/Documents/notes_papers/;m:~/stowfiles/;o:~/OneDrive/;p:~/programs/;r:~/science/ref/;s:~/bin/;t:~/Documents/teaching/;w:~/Documents/work/'

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
    ag --ignore Dropbox --ignore OneDrive --ignore BoxSync -U -g ".pdf$" |
        fast-p |
        fzf --read0 --reverse -e -d $'\t' \
            --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|");
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
            ' |
        cut -z -f 1 -d $'\t' | tr -d '\n' | xargs -r --null zathura - >/dev/null 2>/dev/null
}

fopen() {
    open "$(locate -i "$1")"
}

rmbd() {
    # Delete everything in current path before <date>
    # Format: YYYY-MM-DD HH:MM:SS
    c=$(find . ! -newermt "$1 $2" -printf '.' | wc -c)
    echo "Are you sure you want to delete ""$c"" files from ""$PWD""?"
    select yn in "Yes" "No"; do
        case "$yn" in
        Yes)
            find . -print0 ! -newermt "$1 $2" | xargs -0 rm -rf
            break
            ;;
        No) break ;;
        esac
    done
}

rmad() {
    # Delete everything in current path after <date>
    # Format: YYYY-MM-DD HH:MM:SS
    c=$(find . -newermt "$1 $2" -printf '.' | wc -c)
    echo "Are you sure you want to delete ""$c"" files from ""$PWD""?"
    select yn in "Yes" "No"; do
        case "$yn" in
        Yes)
            find . -print0 -newermt "$1 $2" | xargs -0 rm -rf
            break
            ;;
        No) break ;;
        esac
    done
}

# Github-related
giit() {
    git clone https://github.com/engeir/"$1".git
}

wgit() {
    wget https://github.com/engeir/"$1"/archive/master.zip && unzip master && rm -rf master.zip
}

git_get() {
    curl -u engeir -L -o delete_me_now https://github.com/engeir/"$1"/archive/master.zip && unzip delete_me_now && rm -rf delete_me_now
}

# ImageMagick
remove_menu() {
    convert "$1" -fill white -draw "rectangle 20,100 100,10" "$1"
}

remove_page() {
    convert "$1" -fill white -draw "rectangle 610,1810 800,1850" "$1"
}

transparent() {
    out=${2:-$1}
    col=${3:-white}
    convert "$1" -transparent "$col" "$out"
}

invert() {
    out=${2:-$1}
    convert "$1" -channel RGB -negate "$out"
}

crop() {
    # Crop image. (Default remove white)
    for file in "$@"; do
        convert -trim "$file" "$file"
    done
}

cropv() {
    # Crop image in the vertical direction.
    # (Default remove white.)
    for file in "$@"; do
        croptop "$file"
        cropbottom "$file"
    done
}

croptop() {
    for file in "$@"; do
        convert "$file" -background white -splice 0x1 -background black -splice 0x1 -trim +repage -chop 0x1 "$file"
    done
}

cropbottom() {
    for file in "$@"; do
        convert "$file" -gravity South -background white -splice 0x1 -background black -splice 0x1 -trim +repage -chop 0x1 "$file"
    done
}

trinv() {
    # Make transparent and invert.
    for file in "$@"; do
        transparent "$file" "$file"
        invert "$file" "$file"
    done
}

my_img_magik() {
    # Remove menu and page number, invert and make transparent.
    for file in "$@"; do
        remove_menu "$file"
        remove_page "$file"
        trinv "$file"
    done
}

# Latex compilers
tex0() {
    pdflatex "$1".tex
    pdflatex "$1".tex
    pdflatex "$1".tex
}

tex_bib() {
    pdflatex "$1".tex
    bibtex "$1"
    pdflatex "$1".tex
    pdflatex "$1".tex
}

tex_gls() {
    pdflatex "$1".tex
    makeglossaries "$1"
    pdflatex "$1".tex
    pdflatex "$1".tex
}

tex_full() {
    pdflatex "$1".tex
    bibtex "$1"
    makeglossaries "$1"
    pdflatex "$1".tex
    pdflatex "$1".tex
}
