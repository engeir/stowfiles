" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
" set autochdir                           " Your working directory will always be the same as your working directory
set autoindent                          " Good auto indent
set background=dark                     " tell vim what the background color looks like
set clipboard=unnamedplus               " Copy paste between vim and everything else
set cmdheight=2                         " More space for displaying messages
set colorcolumn=88
set conceallevel=0                      " So that I can see `` in markdown files
set cursorcolumn                        " Enable highlighting of the current column
set cursorline                          " Enable highlighting of the current line
set encoding=utf-8                      " The encoding displayed
set expandtab
set fileencoding=utf-8                  " The encoding written to file
set formatoptions-=crot                 " Stop newline continuation of comments
set hidden                              " Required to keep multiple buffers open
set incsearch
set iskeyword+=-                      	" treat dash separated words as a word text object"
set laststatus=2                        " Always display the status line (0 for vim, 2 for lua... or something idk)
set ma                                  " Modifiable on
set mouse=a                             " Enable your mouse
set nobackup                            " This is recommended by coc
set noerrorbells                        " No sound bc. sound is stupid
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nowrap                              " Display long lines as just one line
set nowritebackup                       " This is recommended by coc
set number relativenumber               " Line numbers
set pumheight=10                        " Makes popup menu smaller
set ruler          			            " Show the cursor position all the time
set scrolloff=8                         " 8 lines bw. the cursor and top of the file
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set showtabline=2                       " Always show tabs
set signcolumn=yes                      " Gives space for signs (e.g. git) in leftmost column
set smartindent                         " Makes indenting smart
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set spell spelllang=en_gb
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set tabstop=4 softtabstop=4             " Insert 4 spaces for a tab (et=expandtab)
set termguicolors
set textwidth=88                        " Automatically insert newline at given column
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set updatetime=300                      " Faster completion
set wildmenu
set wildmode=longest:full,full          " The command line menu is just completed to the longest common string

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vim alternatively you can run :source $MYVIMRC
au BufRead,BufNewFile *.ncl set filetype=ncl
au! Syntax newlang source $VIM/ncl.vim
lua << EOF
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]
EOF

" You can't stop me
cmap w!! w !sudo tee %
