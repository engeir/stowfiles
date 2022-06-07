call plug#begin('~/.vim/plugged')

    " Debugger
    " Plug 'puremourning/vimspector'
    Plug 'szw/vim-maximizer'
    Plug 'mfussenegger/nvim-dap'

    " Colour scheme
    Plug 'sainnhe/gruvbox-material'
    Plug 'tjdevries/colorbuddy.vim'
    Plug 'tjdevries/gruvbuddy.nvim'

    " Better Syntax Support
    Plug 'numToStr/Comment.nvim'
    Plug 'tpope/vim-surround'  " Change surrounding characters
    Plug 'Raimondi/delimitMate'  " Close matching characters
    Plug 'tpope/vim-speeddating'

    " Lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'tami5/lspsaga.nvim'
    Plug 'brymer-meneses/grammar-guard.nvim'
    " Plug 'lewis6991/spellsitter.nvim'

    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'TimUntersberger/neogit'
    Plug 'sindrets/diffview.nvim'  " Nice diff view
    Plug 'ruifm/gitlinker.nvim' " Permalink to line(s) you are on
    Plug 'rhysd/committia.vim'  " Nice split during commits (not working?)
    " Plug '~/projects/githistory-browse.nvim/'
    Plug 'engeir/githistory-browse.nvim'
    Plug 'stsewd/fzf-checkout.vim'

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
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'p00f/nvim-ts-rainbow'
    Plug 'ThePrimeagen/refactoring.nvim'

    " Completion
    Plug 'github/copilot.vim'
    Plug 'hrsh7th/nvim-cmp'
    " Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    " Install the buffer completion source
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Text editing
    " Live preview
    Plug 'frabjous/knap'
    " Used for Markdown highlighting
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'
    Plug 'ellisonleao/glow.nvim', {'branch': 'main'}
    " Latex
    Plug 'lervag/vimtex'
    " Consider using luasnip instead, and transfer the snippet files with
    " https://github.com/L3MON4D3/LuaSnip/issues/201#issuecomment-950132369
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    " Other
    Plug 'airblade/vim-rooter'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'editorconfig/editorconfig-vim'  " Used by pacstall
    Plug 'folke/todo-comments.nvim'
    Plug 'nvim-neorg/neorg'  " Org mode in neovim?

call plug#end()
