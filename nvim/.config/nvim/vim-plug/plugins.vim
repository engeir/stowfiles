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

    " Colour scheme
    Plug 'sainnhe/gruvbox-material'
    Plug 'tjdevries/colorbuddy.vim'
    Plug 'tjdevries/gruvbuddy.nvim'

    " Better Syntax Support
    Plug 'gko/vim-layout'
    Plug 'sainnhe/forest-night'
    Plug 'numToStr/Comment.nvim'
    Plug 'tpope/vim-surround'  " Change surrounding characters
    Plug 'Raimondi/delimitMate'  " Close matching characters
    Plug 'tpope/vim-speeddating'

    " Lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    " let OS = system('uname -s')
    " if OS == "Linux\n"
    "     Plug 'glepnir/lspsaga.nvim'  " Do not work with mac, but with linux
    " elseif OS == "Darwin\n"
    "     Plug 'tami5/lspsaga.nvim'  " Do not work with linux, but with mac
    " endif
    Plug 'tami5/lspsaga.nvim'

    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'  " Enables GBrowse
    " Plug '~/projects/githistory-browse.nvim/'
    " Plug 'engeir/githistory-browse.nvim'
    Plug 'stsewd/fzf-checkout.vim'
    " Python easymotion
    " Plug 'jeetsukumaran/vim-pythonsense'

    " Python
    Plug 'nvie/vim-flake8'
    Plug 'fs111/pydoc.vim'

    " Fuzzy search and open files
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'voldikss/vim-floaterm'
    " Navigation
    Plug 'nvim-lua/plenary.nvim'
    Plug 'ThePrimeagen/harpoon'
    " Telescope
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-bibtex.nvim'

    " Statusline
    Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'code-biscuits/nvim-biscuits'
    Plug 'ThePrimeagen/refactoring.nvim'

    " Completion
    Plug 'Lucklyric/copilot.vim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    " Install the buffer completion source
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Text editing
    " Used for Markdown highlighting
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'
    " Hard wrap or soft wrap of long lines. Also hides unfocused links.
    Plug 'reedes/vim-pencil'
    " Latex
    Plug 'lervag/vimtex'
    " Consider using luasnip instead, and transfer the snippet files with
    " https://github.com/L3MON4D3/LuaSnip/issues/201#issuecomment-950132369
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    " Plug 'sirver/ultisnips'
    " Plug 'honza/vim-snippets'  " For ultisnips
    " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " Other
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'airblade/vim-rooter'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'editorconfig/editorconfig-vim'  " Used by pacstall
    Plug 'sindrets/diffview.nvim'  " Nice diff view
    Plug 'folke/todo-comments.nvim'
call plug#end()

" autocmd CursorHold,CursorHoldI * lua require('code_action_utils').code_action_listener()
