# Stowfiles

<!-- rich-codex --skip-git-checks --use-pty --hide-command --terminal-width 46 --head 24 -->
<!-- ![`cat engeir.txt | lolcat 2>/dev/null`](assets/logo.svg) -->
<!-- ![This is the altered version of the above](assets/logo-alt.svg) -->
<div align="center">
<img src="assets/logo-alt.svg" width="50%">
</div>

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## Neovim

The by far most updated config is the Neovim config. Have a closer look at it
[here](./nvim_lua/.config/nvim/) and on
[Dotfyle](https://dotfyle.com/engeir/stowfiles-nvimlua-config-nvim/readme).

Neovim might be better installed and run by using the `NVIM_APPNAME` variable (requires
Neovim 0.9+):

```bash
# Download
git clone git@github.com:engeir/stowfiles ~/.config/engeir/stowfiles
# Install plugins
NVIM_APPNAME=engeir/stowfiles/nvim_lua/.config/nvim nvim --headless +Lazy! sync +qa
# Run
NVIM_APPNAME=engeir/stowfiles/nvim_lua/.config/nvim nvim
```

## Install

> Uses [GNU Stow](http://www.gnu.org/software/stow/).

Install any one directory or file: (see `stow --help`)

```bash
stow zsh
stow nvim_lua
...
```

Uninstall with the `-D` option:

```bash
stow -D zsh
stow -D nvim_lua
...
```

## Other

A list of packages and binaries installed on my Linux machine is found in
[INSTALLED-linux.md](./INSTALLED-linux.md).

A list of packages and binaries installed on my Mac machine is found in
[INSTALLED-mac.md](./INSTALLED-mac.md).
