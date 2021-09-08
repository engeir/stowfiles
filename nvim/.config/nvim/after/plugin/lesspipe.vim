" https://github-wiki-see.page/m/wofr06/lesspipe/wiki/vim
if exists('g:did_load_filetypes')
    if executable('lesspipe.sh')
        let s:lesspipe_cmd = 'LESSQUIET=1 lesspipe.sh'
    elseif executable('lesspipe')
        let s:lesspipe_cmd = 'lesspipe'
    endif
    if exists('s:lesspipe_cmd') && executable('file')
        augroup lesspipe
            autocmd!
            autocmd BufReadPost *
                        \ if  empty(&l:buftype) && !did_filetype() && !&l:binary && filereadable(bufname('%')) &&
                        \     system('file --mime --brief ' . fnamemodify(resolve(expand('%')), ':p:S')) !~# '^text/' |
                        \   silent exe '%!' . s:lesspipe_cmd . ' ' . expand('%:S') |
                        \   setlocal filetype=text nomodifiable readonly |
                        \ endif
            autocmd Filetype pdf
                        \ exe '%!' . s:lesspipe_cmd . ' ' . expand('%:S') |
                        \ setlocal filetype=text nomodifiable readonly |
        augroup END
    endif
endif
