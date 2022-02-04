" auto-install vim-plug
"if empty(glob('~/.config/nvim/autoload/plug.vim'))
"  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  "autocmd VimEnter * PlugInstall
"  "autocmd VimEnter * PlugInstall | source $MYVIMRC
"endif

call plug#begin('~/.vim/plugged')

    " Debugger
    Plug 'puremourning/vimspector'
    Plug 'szw/vim-maximizer'
    " Better Syntax Support
    Plug 'sainnhe/gruvbox-material'
    Plug 'gko/vim-layout'
    Plug 'sainnhe/forest-night'
    Plug 'numToStr/Comment.nvim'
    Plug 'tpope/vim-surround'  " Change surrounding characters
    Plug 'Raimondi/delimitMate'  " Close matching characters
    Plug 'tpope/vim-speeddating'
    " Lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    " let OS = system('uname -s')
    " if OS == "Linux\n"
    "     Plug 'glepnir/lspsaga.nvim'  " Do not work with mac, but with linux
    " elseif OS == "Darwin\n"
    "     Plug 'tami5/lspsaga.nvim'  " Do not work with linux, but with mac
    " endif
    Plug 'tami5/lspsaga.nvim'
    " Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    " Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'
    " Plug 'airblade/vim-gitgutter'
    Plug 'stsewd/fzf-checkout.vim'
    " Python easymotion
    " Plug 'jeetsukumaran/vim-pythonsense'
    Plug 'fs111/pydoc.vim'
    " Text editing
    " Used for Markdown highlighting
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    " Hard wrap or soft wrap of long lines. Also hides unfocused links.
    Plug 'reedes/vim-pencil'
    " Latex
    Plug 'lervag/vimtex'
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'KeitaNakamura/tex-conceal.vim'
    " Python
    Plug 'nvie/vim-flake8'
    " Fuzzy search and open files
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'voldikss/vim-floaterm'
    " Statusline
    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
    Plug 'mhinz/vim-startify'  " Startup
    " Always place in directory root
    Plug 'airblade/vim-rooter'
    " Motions
    Plug 'easymotion/vim-easymotion'
    " Navigation
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'ThePrimeagen/harpoon'
    " Display icons
    Plug 'kyazdani42/nvim-web-devicons'
    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'code-biscuits/nvim-biscuits'
    " Completion
    Plug 'Lucklyric/copilot.vim'
    Plug 'hrsh7th/nvim-cmp'
    " Install snippet engine (This example installs [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip))
    Plug 'hrsh7th/vim-vsnip'
    " Install the buffer completion source
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'
    " Other
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'editorconfig/editorconfig-vim'
call plug#end()

" autocmd CursorHold,CursorHoldI * lua require('code_action_utils').code_action_listener()
