local status, knap = pcall(require, "knap")
if not status then
    return
end

-- set shorter name for keymap function
local kmap = vim.keymap.set

-- F5 processes the document once, and refreshes the view
kmap('i','<F5>', function() knap.process_once() end)
kmap('v','<F5>', function() knap.process_once() end)
kmap('n','<F5>', function() knap.process_once() end)

-- F6 closes the viewer application, and allows settings to be reset
kmap('i','<F6>', function() knap.close_viewer() end)
kmap('v','<F6>', function() knap.close_viewer() end)
kmap('n','<F6>', function() knap.close_viewer() end)

-- F7 toggles the auto-processing on and off
kmap('i','<F7>', function() knap.toggle_autopreviewing() end)
kmap('v','<F7>', function() knap.toggle_autopreviewing() end)
kmap('n','<F7>', function() knap.toggle_autopreviewing() end)

-- F8 invokes a SyncTeX forward search, or similar, where appropriate
kmap('i','<F8>', function() knap.forward_jump() end)
kmap('v','<F8>', function() knap.forward_jump() end)
kmap('n','<F8>', function() knap.forward_jump() end)

local gknapsettings = {
    texoutputext = "pdf",
    textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    mdtopdf = "pandoc %docroot% -o %outputfile%",
    mdoutputext = "html",
    mdtopdfviewerlaunch = "zathura %outputfile%",
    -- mdtohtmlviewerlaunch = "surf %outputfile%",
    -- mdtohtmlviewerrefresh = "none",
}
vim.g.knap_settings = gknapsettings

-- What I use in my compiler script for markdown
-- pandoc --citeproc --bibliography=/home/een023/science/ref/ref.bib "$file" --filter pandoc-include --filter pandoc-eqnos -s -o "$base".pdf >/dev/null 2>&1
