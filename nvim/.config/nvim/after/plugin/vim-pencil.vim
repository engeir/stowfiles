augroup pencil
	autocmd!
	autocmd FileType markdown,mkd   call pencil#init({'wrap': 'hard', 'autoformat': 0})
	" autocmd FileType tex            call pencil#init({'wrap': 'soft'})
	autocmd FileType text           call pencil#init()
augroup END
let g:pencil#textwidth = 90
