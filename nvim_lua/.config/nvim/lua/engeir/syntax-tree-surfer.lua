local ok, stree = pcall(require, "syntax-tree-surfer")
if not ok then
    return
end

-- stree.setup()

-- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
vim.keymap.set("n", "vsj", function()
    vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
    return "g@l"
end, { silent = true, expr = true })

vim.keymap.set("n", "vsk", function()
    vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
    return "g@l"
end, { silent = true, expr = true })
