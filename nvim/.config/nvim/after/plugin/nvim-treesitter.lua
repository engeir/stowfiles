require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = true,
		custom_captures = {
			-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
			["foo.bar"] = "Identifier",
		},
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = {
			"bash",
			"latex",
			"lua",
			"python",
			"toml",
			"vim",
		}, -- Spell check only in comments, not code, for the given languages
	},
	ensure_installed = {
		"bash",
		"bibtex",
		"css",
		"html",
		"latex",
		"lua",
		"python",
		"scss",
		"toml",
		"vim",
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
