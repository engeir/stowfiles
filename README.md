# Stowfiles

<!-- rich-codex --skip-git-checks --use-pty --hide-command --terminal-width 46 --head 24 -->
<!-- ![`cat engeir.txt | lolcat 2>/dev/null`](assets/logo.svg) -->
<!-- ![This is the altered version of the above](assets/logo-alt.svg) -->
<div align="center">
<img src="assets/logo-alt.svg" width="50%">
</div>

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

## NeoVim

The by far most updated directory/config is the NeoVim config. Have a closer look at it
[here](./nvim_lua/.config/nvim/) and on
[Dotfyle](https://dotfyle.com/engeir/stowfiles-nvimlua-config-nvim/readme).

## Install

> Uses on [GNU Stow](http://www.gnu.org/software/stow/).

Install any one directory/file: (see `stow --help`)

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

## To do

Fix NeoVim LSP. Setting a custom configuration does not work when calling lsp-zero's
init after (as is the suggested way according to lsp-zer). I'm doing something wrong,
figure out what and preferably get rid of lsp-zero and get a better grasp of the minimal
necessary plugins to be able to use LSP's efficiently.
