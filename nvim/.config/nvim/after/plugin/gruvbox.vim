let g:gruvbox_material_contrast = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_cursor = 'green'
let g:gruvbox_material_transparent_background = 1
colorscheme gruvbox-material
set bg=dark
" let g:airline_theme = 'gruvbox_material'

" " From onedark -----------------------------
" "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
"   if (has("nvim"))
"     "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"   endif
"   "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"   "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"   " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"   if (has("termguicolors"))
"     set termguicolors
"   endif
" endif
"
" syntax on
" colorscheme onedark

" " From tokionight ----------------------------
" let g:tokyonight_transparent = 0
" let g:tokyonight_italic_comments = 0
" let g:tokyonight_italic_functions = 0
" let g:tokyonight_italic_keywords = 1
" let g:tokyonight_italic_variables = 0
" colorscheme tokyonight
