local s = vim.opt
-- syntax enable                    -- Enables syntax highlighting
-- s.autochdir                    -- Your working directory will always be the same as your working directory
-- s.guicursor = ""
-- s.formatoptions- = crot          -- Stop newline continuation of comments
-- s.t_Co = 256                     -- Support 256 colors
-- '<,'>!column -t -s="\"" -o="\""

s.autoindent = true -- Good auto indent
s.background = "dark" -- tell vim what the background colour looks like
s.backup = false -- This is recommended by coc
s.clipboard = "unnamedplus" -- Copy paste between vim and everything else
s.cmdheight = 1 -- More space for displaying messages
s.colorcolumn = "88"
s.completeopt = { "menuone", "noselect" } -- mostly just for cmp
s.conceallevel = 0 -- So that I can see `` in markdown files
s.cursorcolumn = true -- Enable highlighting of the current column
s.cursorline = true -- Enable highlighting of the current line
s.encoding = "utf-8" -- The encoding displayed
s.errorbells = false -- No sound bc. sound is stupid
s.expandtab = true
s.fileencoding = "utf-8" -- The encoding written to file
s.fileformats = "unix"
s.fillchars.eob = " "
s.fo = "cq"
s.guifont = "monospace:h17" -- the font used in graphical neovim applications
s.hidden = true -- Required to keep multiple buffers open
s.ignorecase = true -- ignore case in search patterns
s.inccommand = "split" -- Adds a split when you do substitutions
s.incsearch = true
s.iskeyword:append("-")
s.laststatus = 3 -- Always display the status line (0 for vim, 2 for lua... or something idk)
s.ma = true -- Modifiable on
s.mouse = "a" -- Enable your mouse
s.number = true
s.pumheight = 10 -- Makes popup menu smaller
s.relativenumber = true -- Line numbers
s.ruler = true -- Show the cursor position all the time
s.scrolloff = 8 -- 8 lines bw. the cursor and top of the file
s.shiftwidth = 4 -- Change the number of space characters inserted for indentation
s.shortmess:append("c")
s.showcmd = false
s.showmode = false -- We don't need to see things like -- INSERT -- anymore
s.showtabline = 2 -- Always show tabs
s.sidescrolloff = 8
s.signcolumn = "yes" -- Gives space for signs (e.g. git) in leftmost column
s.smartcase = true -- smart case
s.smartindent = true -- Makes indenting smart
s.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
s.softtabstop = 4 -- Insert 4 spaces for a tab (et = expandtab)
s.spell = true
s.spelllang = "en_gb"
s.splitbelow = true -- Horizontal splits will automatically be below
s.splitright = true -- Vertical splits will automatically be to the right
s.swapfile = false -- creates a swapfile
s.tabstop = 4
s.termguicolors = true
s.timeoutlen = 500 -- By default timeoutlen is 1000 ms
s.tw = 88
s.undofile = true -- enable persistent undo
s.updatetime = 300 -- Faster completion
s.whichwrap:append("<,>,[,],h,l")
s.wildmenu = true --
s.wildmode = "longest:full,full" -- The command line menu is just completed to the longest common string
s.wm = 0 -- Set textwidth, but don't automatically insert newline at given column
s.wrap = false -- Display long lines as just one line
s.writebackup = false -- This is recommended by coc
