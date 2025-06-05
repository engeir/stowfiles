return {
  {
    "terrastruct/d2-vim",
    enabled = true,
    ft = { "d2" },
  },
  {
    "ravsii/tree-sitter-d2",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    build = "make nvim-install",
  },
}
