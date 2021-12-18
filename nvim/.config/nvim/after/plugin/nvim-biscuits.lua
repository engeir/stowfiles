require('nvim-biscuits').setup({
  toggle_keybind = "<leader>cb",
  cursor_line_only = true,
  show_on_start = true,
  default_config = {
    max_length = 12,
    min_distance = 5,
    prefix_string = " 📎 "
  },
  language_config = {
    html = {
      prefix_string = " 🌐 "
    },
    javascript = {
      prefix_string = " ✨ ",
      max_length = 80
    },
    python = {
      max_length = 10,
      prefix_string = " 🍪 "
    }
  }
})
