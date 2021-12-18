" See:
" https://www.youtube.com/watch?v=gZCXaF-Lmco&ab_channel=NickNisi
" https://www.chrisatmachine.com/Neovim/01-vim-plug/
" https://www.youtube.com/watch?v=FW2X1CXrU1w
source $HOME/.config/nvim/general/settings.vim

" let g:coq_settings = { 'auto_start': 'shut-up' }
" Plugins:
source $HOME/.config/nvim/vim-plug/plugins.vim

lua << EOF
-- require 'statuslines.darkline'
-- require 'statuslines.spaceline'
-- require 'statuslines.evilline'
require 'statuslines.galaxyline-line'
EOF

" Other:
source $HOME/.config/nvim/keys/mappings.vim
" Create a venv and install pynvim, i.e.
" python -m pip install --user --upgrade pynvim
" Finally we set it as the python3_host_prog:
" Probably need to use uname -o
let OS = system('uname -s')
let OS2 = system('uname -m')
if OS == "Linux\n"
    if OS2 != "aarch64\n"
        let g:python3_host_prog = expand("/home/een023/.pyenv/versions/py3nvim/bin/python")
        source /home/een023/.config/cdo/add_cdo_complete_to_your_vimrc
    endif
elseif OS == "Darwin\n"
    let g:python3_host_prog = expand("/Users/eirikenger/.pyenv/versions/py3nvim/bin/python")
endif
