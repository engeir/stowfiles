# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export VISUAL="nvim"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="st"
# export ZDOTDIR="$HOME/.config/zsh"
export PATH=$PATH:/usr/local/go/bin:/home/een023/go/bin:/home/een023/.cargo/bin
export PATH=$HOME/.config/rofi/bin:$PATH
export FZF_COMPLETION_TRIGGER='\\'
export GH_PAT_POLYBAR=$(pass API/polybar_github)
export WTF_GITHUB_TOKEN=$(pass API/wtf_github)
export WTF_GITHUB_BASE_URL="https://github.com/engeir"
export AFTERSHIP_API_KEY=$(pass API/aftership)
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

# # Config for fzf
# FD_OPTIONS="--follow --exclude .git --exclude node_modules"
# FD_CTRL_T_OPTIONS="--type d --type f --hidden --exclude .git --exclude .config/nnn --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv --exclude .conda --exclude .dropbox-dist --exclude .vscode --exclude .vscode-insiders --exclude miniconda3 --exclude .virtualenvs --exclude snap --exclude gems --exclude .wine --exclude extensions --exclude coreutils-8.32 --exclude freetype-2.10.4 --exclude .cargo --exclude Downloads --exclude R --exclude .Mathematica --exclude OneDrive --exclude BoxSync --exclude Dropbox"
# # FZF settings
# export FZF_BASE=/usr/bin
# # export DISABLE_FZF_AUTO_COMPLETION="true"
# export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
# # export FZF_DEFAULT_OPTS="--no-mouse --layout=reverse --height 100% -1 --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (batcat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(batcat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
# # export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fdfind --type f --type 1 $FD_OPTIONS"
# # export FZF_DEFAULT_COMMAND="--layout=reverse --inline-info"
# export FZF_CTRL_T_COMMAND="fdfind $FD_CTRL_T_OPTIONS"
# export FZF_ALT_C_COMMAND="fdfind --type d $FD_OPTIONS"
# # _fzf_compgen_path() {
# # 	fdfind --hidden --follow --exclude ".git" . "$1"
# #   }

# export BAT_PAGER="less -R"