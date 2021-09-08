if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
  max_preview_lines = 40,
}

EOF

nnoremap <silent> <C-p> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <leader>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
" nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader>rn :Lspsaga rename<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
