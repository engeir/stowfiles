return {
    {
        "3rd/image.nvim",
        enabled = false,
        init = function()
            -- For image.nvim
            package.path = package.path .. ";~/.luarocks/share/lua/5.1/?/init.lua;"
            package.path = package.path .. ";~/.luarocks/share/lua/5.1/magick/init.lua;"
            package.path = package.path .. ";~/.luarocks/share/lua/5.1/magick/;"
        end,
        config = function()
            -- default config
            require("image").setup({
                backend = "ueberzug",
                integrations = {
                    markdown = {
                        enabled = true,
                        sizing_strategy = "auto",
                        download_remote_images = true,
                        clear_in_insert_mode = false,
                        only_render_image_at_cursor = false,
                    },
                    neorg = {
                        enabled = true,
                        download_remote_images = true,
                        clear_in_insert_mode = false,
                        only_render_image_at_cursor = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                kitty_method = "normal",
                kitty_tmux_write_delay = 10,          -- makes rendering more reliable with Kitty+Tmux
                window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
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
