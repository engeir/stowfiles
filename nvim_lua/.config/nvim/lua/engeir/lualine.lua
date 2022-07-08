local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

lualine.setup({
	options = {
		theme = "gruvbox",
		-- theme = "auto",
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 3,
			},
		},
	},
	extensions = {
		"toggleterm",
	},
})
