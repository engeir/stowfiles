"ScreenShots in Markup
augroup WRIGHTING
    autocmd!
    autocmd FileType pandoc nnoremap <buffer> cic :call pandoc#after#nrrwrgn#NarrowCodeblock()<cr>
    autocmd FileType markdown,pandoc nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'),'.png')
    autocmd FileType latex,tex nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#LatexScreenShot'),'.png')
    autocmd FileType dotoo,org nnoremap <buffer> <leader>i       :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'),'.eps')
    autocmd FileType groff,troff,nroff nnoremap <buffer> <leader>i     :<C-U>call dotvim#ImportScreenShot(function('dotvim#GroffScreenShot'),'.eps')
    " autocmd BufRead,BufNewFile *.md,*.tex,*.wiki call dotvim#WordProcessor()
    " autocmd FileType markdown,pandoc,dotoo,org execute 'setlocal dictionary+='. &runtimepath . '/extra/dict/latex_comp.txt'
augroup END

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
" nnoremap <M-j>    :resize -2<CR>  " Already mapped to <leader>{+,-}
" nnoremap <M-k>    :resize +2<CR>
" Change the vertical split by factor +1.5 and -.67
nnoremap <silent> <Leader>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <M-+>    :resize +2<CR>
nnoremap <M-->    :resize -2<CR>

" Move lines up and down
xnoremap J :move '>+1<CR>gv=gv
xnoremap K :move '<-2<CR>gv=gv
inoremap <C-j> :m .+1<CR>==
inoremap <C-k> :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" " Easy CAPS
" inoremap <c-u> <ESC>viwUi
" nnoremap <c-u> viwU<Esc>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" My additions

" Open folder view
" nnoremap <leader>pv :to vsp <bar> :Ex <bar> :vertical resize 40<CR>

" Format code
nnoremap <silent><leader><leader>f :lua vim.lsp.buf.formatting_sync()<CR>
" Autocompilers
map <leader>a :!setsid autocomp % &<CR>

" Open pdf from source (e.g. md file)
map <leader><leader>o :!open_output % &<CR>

" Search files
" Search files (open new or from buffer) with fzf
nnoremap <silent><leader>o :Files<CR>
nnoremap <silent><leader>O :Rg<CR>
nnoremap <silent><leader>b :Buff<CR>
" nnoremap <silent><leader>l :BLines<CR>
nnoremap <silent><leader>L :BLines!<CR>
" Remove file from buffer
nnoremap <silent><leader>cc :bd<CR>

" Add more breakpoints for the undo
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Add more breakpoints for the history jumping (ctrl-O)
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Y should behave similar to D and C (this is default in neovim)
nnoremap Y y$

" Add n newlines and continue in normal mode
nnoremap <silent> <leader>n :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>N :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Turn off search highlight
nnoremap <silent><leader>h :noh<CR>
" Moving through searches, better
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" Moving over paragraphs, better
nnoremap { {zz
nnoremap } }zz

" Start/turn off spellcheck
nnoremap <silent><leader>s :set spell spelllang=en_gb<CR>
nnoremap <silent><leader>S :set spell!<CR>
" Spell checker mappings (set spell spelllang=en_gb)
" Go back to last misspelled word and pick first suggestion.
inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u
" Select last misspelled word (typing will edit).
nnoremap <C-s> <Esc>[sve<C-G>
inoremap <C-s> <Esc>[sve<C-G>
snoremap <C-K> <Esc>b[sviw<C-G>

" Lua snippet in vimscript:
nmap <leader>T <Plug>PlenaryTestFile
" nnoremap <leader>GH :GhBrowse<CR>
