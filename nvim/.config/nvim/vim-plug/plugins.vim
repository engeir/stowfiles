" auto-install vim-plug
"if empty(glob('~/.config/nvim/autoload/plug.vim'))
"  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  "autocmd VimEnter * PlugInstall
"  "autocmd VimEnter * PlugInstall | source $MYVIMRC
"endif

call plug#begin('~/.vim/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    Plug 'sainnhe/gruvbox-material'
    Plug 'gko/vim-layout'
    Plug 'sainnhe/forest-night' 
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-speeddating'
    " Git
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " Python easymotion
    " Plug 'jeetsukumaran/vim-pythonsense'
    Plug 'fs111/pydoc.vim'
    Plug 'preservim/tagbar'
    " Text editing
    " Used for Markdown highlighting
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    " Hard wrap or soft wrap of long lines. Also hides unfocused links.
    Plug 'reedes/vim-pencil'
    " Goyo just removes everything but the text, nice for writing.
    Plug 'junegunn/goyo.vim'
    " Latex
    Plug 'lervag/vimtex'
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'KeitaNakamura/tex-conceal.vim'
    " Fuzzy search and open files
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'voldikss/vim-floaterm'
    " Statusline
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mhinz/vim-startify'  " Startup
    " Always place in directory root
    Plug 'airblade/vim-rooter'
    " Motions
    Plug 'easymotion/vim-easymotion'
call plug#end()