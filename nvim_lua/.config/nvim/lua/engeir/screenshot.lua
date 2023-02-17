-- function! dotvim#OrgScreenShot(desc, dir, filename)
-- 	call setline('.', printf('[[file:%s/%s]]', a:dir, a:filename))
-- endfunction
--
-- function! dotvim#MarkdownScreenShot(desc, dir, filename)
-- 	call setline('.', '!['.a:desc.']('.a:dir.'/'.a:filename.'){ width=50% }')
-- endfunction
--
-- function! dotvim#LatexScreenShot(desc, dir, filename)
-- 	call setline('.', '\includegraphics[width=\linewidth]{'.a:dir.'/'.a:filename.'}')
-- endfunction
--
-- function! dotvim#GroffScreenShot(desc, dir, filename)
-- 	call setline('.', printf('.PSPIC %s/%s', a:dir, a:filename))
-- endfunction
--
-- "add a screenshot to a markdown file
-- function! dotvim#ImportScreenShot(screenshotfunc, extension)
-- 	let dir = 'pic'
-- 	let desc = getline('.')
-- 	let filename = substitute(getline('.'), ' ', '_', 'g').a:extension
-- 	if !isdirectory(dir)
-- 		call mkdir(dir)
-- 	endif
-- 	call a:screenshotfunc(desc, dir, filename)
-- 	call system('import "'.dir.'/'.filename.'"')
-- 	if v:shell_error
-- 		call setline('.', desc)
-- 	endif
-- endfunction

function ImportScreenShot(screenshotfunc, ext)
    local dir = "assets/images"
end
