return {
  {
    "3rd/image.nvim",
    enabled = (
      vim.loop.os_homedir() == "/home/een023"
      or vim.loop.os_homedir() == "/home/eirikre"
    ),
    build = "luarocks --local --lua-version=5.1 install magick",
    event = "BufReadPre",
    init = function()
      -- For image.nvim
      package.path = package.path
        .. ";"
        .. vim.fn.expand("$HOME")
        .. "/.luarocks.share/lua/5.1/?/init.lua;"
      package.path = package.path
        .. ";"
        .. vim.fn.expand("$HOME")
        .. "/.luarocks/share/lua/5.1/?/init.lua;"
      package.path = package.path
        .. ";"
        .. vim.fn.expand("$HOME")
        .. "/.luarocks/share/lua/5.1/?.lua;"
    end,
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            sizing_strategy = "auto",
            download_remote_images = true,
            clear_in_insert_mode = false,
            only_render_image_at_cursor = true,
          },
          neorg = {
            enabled = false,
            download_remote_images = true,
            clear_in_insert_mode = false,
            only_render_image_at_cursor = false,
          },
          typst = {
            enabled = false,
          },
        },
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
        max_height = nil,
        max_height_window_percentage = 40,
        max_width = 87,
        max_width_window_percentage = nil,
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end,
  },
  -- {
  --     "samodostal/image.nvim",
  --     enabled = false,
  --     opts = {
  --         render = {
  --             min_padding = 5,
  --             show_label = true,
  --             use_dither = true,
  --         },
  --         events = {
  --             update_on_nvim_resize = true,
  --         },
  --     },
  -- },
}
