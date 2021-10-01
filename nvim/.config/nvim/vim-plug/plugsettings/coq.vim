" 🐓 Coq completion settings

" Set recommended to false
let g:coq_settings = { "keymap.recommended": v:false }

" " Keybindings
" ino <silent><expr> <Esc> pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
" ino <silent><expr> <C-c> pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
" ino <silent><expr> <BS>  pumvisible() ? "\<C-e><BS>"  : "\<BS>"
" ino <silent><expr> <CR> pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
" ino <silent><expr> <C-n> pumvisible() ? "\<C-n>" : "\<Tab>"
" ino <silent><expr> <C-p> pumvisible() ? "\<C-p>" : "\<BS>"
