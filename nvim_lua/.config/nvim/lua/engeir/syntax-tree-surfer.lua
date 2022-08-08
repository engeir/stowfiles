local ok, stree = pcall(require, "syntax-tree-surfer")
if not ok then
    return
end

stree.setup()
