alias sxiv="sxiv -b"
alias publish_flottflyt="rsync -rtvzP --delete ~/projects/flottflyt/public/ root@flottflyt.xyz:/var/www/flottflyt"
alias publish_gallery_flottflyt="rsync -rtvzP ~/projects/gallery-flottflyt/photo-stream/_site/ root@flottflyt.xyz:/var/www/gallery-flottflyt"
alias publish_eirikenger="rsync -rtvzP ~/projects/eirikenger/ root@flottflyt.xyz:/var/www/eirikenger"

export GOROOT="/usr/local/Cellar/go/1.21.0/libexec/"
export NNN_BMS="b:~/photos/Bilder/Canon EOS M50;c:~/.config;d:~/Downloads;m:~/stowfiles;p:~/programs;s:~/.local/bin;w:~/OneDrive - UiT Office 365/Skole"
export NNN_PLUG='d:diffs;f:fzcd;j:autojump;l:launch;p:preview-tui2;t:nmount;v:imgview'
# export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
