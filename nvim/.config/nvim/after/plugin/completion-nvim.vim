" " autocmd BufEnter * lua require'completion'.on_attach()
"
" " lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
"
" let g:completion_enable_snippet = 'UltiSnips'
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" let g:completion_trigger_on_delete = 1
"
" " Use <Tab> and <S-Tab> to navigate through popup menu
" " inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" " let g:completion_chain_complete_list = {
" "     \'default' : [
" "     \    {'complete_items': ['lsp', 'snippet', 'path']},
" "     \    {'mode': '<c-p>'},
" "     \    {'mode': '<c-n>'}
" "     \]
" "     \}
" let g:completion_chain_complete_list = {
"     \       'default': [
"     \           {'complete_items': ['lsp', 'snippet']},
"     \           {'complete_items': ['path'], 'triggered_only': ['/']},
"     \           {'mode': '<c-p>'},
"     \           {'mode': '<c-n>'}
"     \       ]
"     \   }
"
" " let g:completion_confirm_key = ""
" imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
"                  \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"
" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)
"
" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
"
" " Avoid showing message extra message when using completion
" set shortmess+=c
