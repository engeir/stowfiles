" See https://www.youtube.com/watch?v=gZCXaF-Lmco&ab_channel=NickNisi
" and https://www.chrisatmachine.com/Neovim/01-vim-plug/
source $HOME/.config/nvim/general/settings.vim

" Plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

source $HOME/.config/nvim/vim-plug/plugsettings/coc.vim
source $HOME/.config/nvim/vim-plug/plugsettings/gitgutter.vim
source $HOME/.config/nvim/vim-plug/plugsettings/gruvbox.vim
source $HOME/.config/nvim/vim-plug/plugsettings/lesspipe.vim
source $HOME/.config/nvim/vim-plug/plugsettings/nvim-colorizer.lua
source $HOME/.config/nvim/vim-plug/plugsettings/pydoc-improved.vim
source $HOME/.config/nvim/vim-plug/plugsettings/tagbar.vim
source $HOME/.config/nvim/vim-plug/plugsettings/tex-conceal.vim
source $HOME/.config/nvim/vim-plug/plugsettings/ultisnips.vim
source $HOME/.config/nvim/vim-plug/plugsettings/vim-markdown.vim
source $HOME/.config/nvim/vim-plug/plugsettings/vim-maximizer.vim
source $HOME/.config/nvim/vim-plug/plugsettings/vim-pencil.vim
source $HOME/.config/nvim/vim-plug/plugsettings/vimspector.vim
source $HOME/.config/nvim/vim-plug/plugsettings/vimtex.vim

" Other
source $HOME/.config/nvim/keys/mappings.vim
let OS = system('uname -s')
if $OS == 'Linux'
    source /home/een023/.config/cdo/add_cdo_complete_to_your_vimrc
    let g:python3_host_prog = '/home/een023/.pyenv/versions/py3nvim/bin/python'
elseif $OS == 'Darwin'
    let g:python3_host_prog = expand("/Users/eirikenger/.pyenv/versions/py3nvim/bin/python")
endif
