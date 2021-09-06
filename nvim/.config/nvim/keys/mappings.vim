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

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
" nnoremap <C-s> :w<CR>
" Alternate way to quit
" nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
" nnoremap <C-c> <Esc>
" <TAB>: completion. DO NOT WANT THIS.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

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

" Git
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git add .<CR>
nnoremap <leader>gg :GitGutterToggle<CR>

" Open folder view
" nnoremap <leader>pv :to vsp <bar> :Ex <bar> :vertical resize 40<CR>
nnoremap <leader>pv :FloatermNew --wintype=vsplit --opener=vsplit --autoclose=2 nnn<CR>

" Autocompilers
nnoremap <silent><leader>t :vert ter<CR>
vmap <C-r> :'<,'>FloatermNew --wintype=vsplit python<CR>
nnoremap <silent><leader>r :FloatermNew --wintype=vsplit --autoclose=0 python %<CR>
map <leader>a :!setsid autocomp % &<CR>

" Open pdf from source (e.g. md file)
" map <leader><leader>o :!xdg-open "$(echo % | awk -F. '{print $1}').pdf" &<CR>
map <leader><leader>o :!open_output % &<CR>

" Search files
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nnoremap <C-p> :GFiles<CR>
" Search files (open new or from buffer) with fzf
nnoremap <silent><leader>o :Files<CR>
nnoremap <silent><leader>O :Rg<CR>
nnoremap <silent><leader>b :Buff<CR>
" nnoremap <silent><leader>l :BLines<CR>
nnoremap <silent><leader>L :BLines!<CR>

" Add more breakpoints for the undo
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Add more breakpoints for the history jumping (ctrl-O)
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Y should behave similar to D and C
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

