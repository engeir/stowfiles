
lua << EOF
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

EOF

" " Use surf as the default viewer
" let g:knap_settings = {
"     \ "mdtohtmlviewerlaunch" : "surf %outputfile%",
"     \ "mdtohtmlviewerrefresh" : "none",
" \ }
