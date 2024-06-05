return {
  { "xiyaowong/transparent.nvim", config = true },
  {
    "tjdevries/colorbuddy.vim",
    enabled = false,
    config = function()
      require("colorbuddy").colorscheme("engeir.lazy.colorschemes.mycolorscheme")
    end,
  },
  { "tjdevries/gruvbuddy.nvim", enabled = false },
  {
    "marko-cerovac/material.nvim",
    enabled = false,
    opts = {
      contrast = {
        terminal = false, -- Enable contrast for the built-in terminal
        sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false, -- Enable contrast for floating windows
        cursor_line = false, -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
        filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
      },
      styles = {
        -- Give comments style such as bold, italic, underline, undercurl etc.
        comments = {},
        strings = {},
        keywords = { [[ italic = true ]] },
        functions = {},
        variables = {},
        operators = {},
        types = {},
      },
      contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
        "terminal", -- Darker terminal background
        "packer", -- Darker packer background
        "qf", -- Darker qf list background
      },
      high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false, -- Enable higher contrast text for darker style
      },
      disable = {
        colored_cursor = true, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (Neovim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Hide the end-of-buffer lines
      },
      lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
      async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
      custom_highlights = {}, -- Overwrite highlights with your own
      custom_colors = nil, -- If you want to everride the default colors, set this to a function
      plugins = {
        -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
        trouble = true,
        nvim_cmp = true,
        neogit = true,
        gitsigns = true,
        git_gutter = true,
        telescope = true,
        nvim_tree = true,
        sidebar_nvim = true,
        lsp_saga = true,
        nvim_dap = true,
        nvim_navic = true,
        which_key = true,
        sneak = true,
        hop = true,
        indent_blankline = true,
        nvim_illuminate = true,
      },
    },
    config = function()
      vim.cmd("colorscheme material")
      -- vim.g.material_style = "darker"
      require("material.functions").change_style("oceanic")

      vim.api.nvim_set_keymap(
        "n",
        "<leader>mm",
        [[<Cmd>lua require('material.functions').toggle_style()<CR>]],
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "sainnhe/gruvbox-material",
    event = "VeryLazy",
    enabled = true,
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_contrast = "soft"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_cursor = "green"
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd("colorscheme gruvbox-material")
      -- vim.opt.bg="dark"
    end,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    init = function()
      vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
      vim.cmd([[colorscheme catppuccin]])
    end,
    opts = {
      transparent_background = false,
      term_colors = false,
      compile = {
        enabled = false,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
      },
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = {},
        conditionals = { "italic" },
        loops = { "italic" },
        functions = {},
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
      },
      color_overrides = {},
      highlight_overrides = {},
    },
  },
}
