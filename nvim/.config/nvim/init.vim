" Create a venv and install pynvim, i.e.
" python -m pip install --user --upgrade pynvim
" Finally we set it as the python3_host_prog:
" Probably need to use uname -o
let OS = system('uname -s')
let OS2 = system('uname -n')
if OS == "Linux\n"
    if OS2 == "ubuntu-work\n"
        let g:python3_host_prog = expand("$HOME/.pyenv/versions/py3nvim/bin/python")
        source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc
    elseif OS2 =~ "fram.sigma2.no\n"
        let g:python3_host_prog = expand("$HOME/Envs/py3nvim/bin/python")
        source $HOME/.config/cdo/add_cdo_complete_to_your_vimrc
    endif
elseif OS == "Darwin\n"
    let g:python3_host_prog = expand("$HOME/.pyenv/versions/py3nvim/bin/python")
endif

" See:
" https://www.youtube.com/watch?v=gZCXaF-Lmco&ab_channel=NickNisi
" https://www.chrisatmachine.com/Neovim/01-vim-plug/
" https://www.youtube.com/watch?v=FW2X1CXrU1w
source $HOME/.config/nvim/general/settings.vim

" Plugins:
source $HOME/.config/nvim/vim-plug/plugins.vim

lua << EOF

require 'globals'
require("engeir.lsp")

EOF

" Other:
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/autoload/sage.vim
