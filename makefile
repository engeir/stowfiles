install-ubuntu:
    # Clean
    stow -D X
    stow -D aptery
    stow -D alacritty
    stow -D bspwm
    stow -D compton
    stow -D lf
    stow -D mimi
    stow -D mpv
    stow -D nvim
    stow -D starship
    stow -D sxhkd
    stow -D sxiv
    stow -D tmux
    stow -D whoogle
    stow -D zathura
    stow -D zsh
    # Install
    stow X
    stow aptery
    stow alacritty
    stow bspwm
    stow compton
    stow lf
    stow mimi
    stow mpv
    stow nvim
    stow starship
    stow sxhkd
    stow sxiv
    stow tmux
    stow whoogle
    stow zathura
    stow zsh

install-mac:
	# Clean
	stow -D lf_mac
	stow -D nvim
	stow -D starship
	stow -D zsh_mac
	stow -d alacritty_mac
	# Install
	stow alacritty_mac
	stow lf_mac
	stow nvim
	stow starship
	stow zsh_mac
