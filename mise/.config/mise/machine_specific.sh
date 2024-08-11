#!/usr/bin/env bash

name_getter() {
    uname -a | grep -i "$1" >/dev/null 2>&1
}
# What OS are we running?
if [[ $(uname) == "Darwin" ]]; then
    export MACHINE="darwin"
elif command -v freebsd-version >/dev/null; then
    export MACHINE="freebsd"
elif name_getter "ubuntu"; then
    export MACHINE="ubuntu"
elif name_getter "arch"; then
    export MACHINE="arch"
else
    echo 'Unknown OS!'
    exit 0
fi

if [[ $MACHINE == "ubuntu" ]]; then
    export NNN_PLUG='a:bookmarks;b:bibfinder;c:diffs;d:dragdrop;f:fzcd;i:ipinfo;j:autojump;m:viewmedia;o:organize;p:preview-tui2;r:rm-send;s:fzplug;u:upload'
    export NNN_BMS='b:~/Pictures/;c:~/.config/;d:~/Downloads/;l:~/.local;n:~/Documents/notes_papers/;m:~/stowfiles/;o:~/OneDrive/;p:~/programs/;r:~/science/ref/;s:~/bin/;t:~/Documents/teaching/;w:~/Documents/work/'
    # IMPORTANT: without this, images are sometimes not opened, other times opened in Brave
    # export NNN_OPENER="/home/een023/bin/xdg-open-awsm"
    export NNN_OPENER="/home/een023/.config/nnn/plugins/nuke"
elif [[ $MACHINE == "darwin" ]]; then
    export NNN_BMS="b:~/photos/Bilder/Canon EOS M50;c:~/.config;d:~/Downloads;m:~/stowfiles;p:~/programs;s:~/.local/bin;w:~/OneDrive - UiT Office 365/Skole"
    export NNN_PLUG='a:bookmarks;b:bibfinder;c:diffs;d:dragdrop;f:fzcd;i:ipinfo;j:autojump;m:viewmedia;o:organize;p:preview-tui;r:rm-send;s:fzplug;u:upload'
elif [[ $MACHINE == "arch" ]]; then
    # export NNN_PLUG=
    export NNN_BMS='b:~/Pictures/;c:~/.config/;d:~/Downloads/;l:~/.local;m:~/stowfiles/;p:~/programs/;s:~/bin/'
    # export NNN_OPENER=
fi
