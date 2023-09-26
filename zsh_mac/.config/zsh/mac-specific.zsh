alias sxiv="sxiv -b"
alias publish_flottflyt="rsync -rtvzP --delete ~/projects/flottflyt/public/ root@flottflyt.xyz:/var/www/flottflyt"
alias publish_gallery_flottflyt="rsync -rtvzP ~/projects/gallery-flottflyt/photo-stream/_site/ root@flottflyt.xyz:/var/www/gallery-flottflyt"
alias publish_eirikenger="rsync -rtvzP ~/projects/eirikenger/ root@flottflyt.xyz:/var/www/eirikenger"

export NNN_BMS="b:~/photos/Bilder/Canon EOS M50;c:~/.config;d:~/Downloads;m:~/stowfiles;p:~/programs;s:~/.local/bin;w:~/OneDrive - UiT Office 365/Skole"
# export NNN_PLUG='d:diffs;f:fzcd;j:autojump;l:launch;p:preview-tui2;t:nmount;v:imgview'
export NNN_PLUG='a:bookmarks;b:bibfinder;c:diffs;d:dragdrop;f:fzcd;i:ipinfo;j:autojump;m:viewmedia;o:organize;p:preview-tui;r:rm-send;s:fzplug;u:upload'
# export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
