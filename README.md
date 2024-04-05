# Stowfiles

<!-- rich-codex --skip-git-checks --use-pty --hide-command --terminal-width 46 --head 24 -->
<!-- ![`cat engeir.txt | lolcat 2>/dev/null`](assets/logo.svg) -->
<!-- ![This is the altered version of the above](assets/logo-alt.svg) -->
<div align="center">
<img src="assets/logo-alt.svg" width="50%">
</div>

<sup>Latest version: v1.11.6</sup> <!-- x-release-please-version -->

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

## Config installation

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

## Program installation

A list of packages and binaries installed on my Linux machine is found in
[INSTALLED-linux.md](./INSTALLED-linux.md).

A list of packages and binaries installed on my Mac machine is found in
[INSTALLED-mac.md](./INSTALLED-mac.md).

### Auto update

The script [`.update-installed`](./.update-installed) can be used to update the
installed packages and binaries listed in the `INSTALLED-<machine>.md` files.

```bash
.update-installed -h
```

### Re-install

If you want to (re-)install a program that is listed in the `INSTALLED-<machine>.md`
files, this can be done using the [`.reinstall`](./.reinstall) script.

```bash
.reinstall -h
```
