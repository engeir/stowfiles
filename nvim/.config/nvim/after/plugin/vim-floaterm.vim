nnoremap <silent><leader>ft :FloatermToggle<CR>
nnoremap <silent><leader>t :FloatermNew --wintype=vsplit --autohide=0 python<CR><C-\><C-n><C-w>h
nnoremap <leader>pv :FloatermNew --wintype=float --position=right --autoclose=2 nnn -d<CR>
" Select between %% (mimic jupyter notebook)
nnoremap <silent><leader>H :/%%<CR>VN
vmap <C-r> :'<,'>FloatermSend <CR>
nnoremap <silent><leader>r :FloatermNew --wintype=float --position=right --autoclose=0 compiler %<CR>
