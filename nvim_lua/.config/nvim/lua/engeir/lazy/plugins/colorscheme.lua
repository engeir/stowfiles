return {
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_contrast = "soft"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_material_cursor = "green"
      vim.g.gruvbox_material_transparent_background = 1
      -- vim.cmd.colorscheme("gruvbox-material")
      -- vim.opt.bg="dark"
    end,
  },
  {
    "sainnhe/sonokai",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.sonokai_style = "shusia"
      vim.g.sonokai_style = "maia"
      vim.g.sonokai_transparent_background = 1
      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "catppuccin/nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    init = function()
      vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
      -- vim.cmd([[colorscheme catppuccin]])
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
  {
    "rebelot/kanagawa.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    init = function()
      require("kanagawa").setup({
        theme = "dragon",
        colors = {
          theme = {
            all = {
              ui = {
                bg = "none",
                bg_gutter = "none",
              },
            },
          },
        },
      })
      -- vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
}
