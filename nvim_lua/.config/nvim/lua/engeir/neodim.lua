local ok, neodim = pcall(require, "neodim")
if not ok then
    return
end
neodim.setup({
    alpha = 0.5, -- make the dimmed text even dimmer
    hide = {
        -- virtual_text = false,
        -- signs = false,
        -- underline = false,
    },
})
