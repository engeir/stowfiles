" See:
" https://www.youtube.com/watch?v=gZCXaF-Lmco&ab_channel=NickNisi
" https://www.chrisatmachine.com/Neovim/01-vim-plug/
" https://www.youtube.com/watch?v=FW2X1CXrU1w
source $HOME/.config/nvim/general/settings.vim

let g:coq_settings = { 'auto_start': 'shut-up' }
" Plugins:
source $HOME/.config/nvim/vim-plug/plugins.vim

" " source $HOME/.config/nvim/vim-plug/plugsettings/coc.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/firenvim.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/completion-nvim.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/fzf-checkout.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/fzf.vim
" " source $HOME/.config/nvim/vim-plug/plugsettings/gitgutter.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/gruvbox.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/lesspipe.vim
" luafile $HOME/.config/nvim/vim-plug/plugsettings/lsp-signature.lua
" " source $HOME/.config/nvim/vim-plug/plugsettings/lspsaga.vim
" luafile $HOME/.config/nvim/vim-plug/plugsettings/nvim-cmp.lua
" luafile $HOME/.config/nvim/vim-plug/plugsettings/nvim-lspconfig.lua
" luafile $HOME/.config/nvim/vim-plug/plugsettings/nvim-colorizer.lua
" luafile $HOME/.config/nvim/vim-plug/plugsettings/gitsigns.lua
" luafile $HOME/.config/nvim/vim-plug/plugsettings/nvim-treesitter.lua
" source $HOME/.config/nvim/vim-plug/plugsettings/pydoc-improved.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/tex-conceal.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/telescope.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/ultisnips.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/vim-flake8.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/vim-markdown.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/vim-maximizer.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/vim-pencil.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/vimspector.vim
" source $HOME/.config/nvim/vim-plug/plugsettings/vimtex.vim

" Other:
source $HOME/.config/nvim/keys/mappings.vim
" Create a venv and install pynvim, i.e.
" python -m pip install --user --upgrade pynvim
" Finally we set it as the python3_host_prog:
let OS = system('uname -s')
if OS == "Linux\n"
    let g:python3_host_prog = expand("/home/een023/.pyenv/versions/py3nvim/bin/python")
    source /home/een023/.config/cdo/add_cdo_complete_to_your_vimrc
elseif OS == "Darwin\n"
    let g:python3_host_prog = expand("/Users/eirikenger/.pyenv/versions/py3nvim/bin/python")
endif
