-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will help provide clearer
-- error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- config.window_decorations = "TITLE"
config.audible_bell = "Disabled"
config.font = wezterm.font("Recursive")
local font_size
if wezterm.target_triple == "x86_64-apple-darwin" then
    font_size = 13.5
else
    font_size = 11.0
end
config.font_size = font_size
config.adjust_window_size_when_changing_font_size = false
-- For example, changing the color scheme:
-- This affects the colors reported/used by `pastel`, so is seems better to set
-- LS_COLORS and not the theme.
-- config.color_scheme = "Gruvbox dark, medium (base16)"
config.colors = {
    background = "#282828",
}
config.window_background_gradient = require("configs.window_background_gradient")
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.9
local opacity_crement = 0.02
wezterm.on("toggle-opacity", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = 0.5
    else
        overrides.window_background_opacity = nil
    end
    window:set_config_overrides(overrides)
end)
wezterm.on("increment-opacity", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = config.window_background_opacity + opacity_crement
    elseif overrides.window_background_opacity < 0.99 then
        overrides.window_background_opacity = overrides.window_background_opacity + opacity_crement
    end
    window:set_config_overrides(overrides)
end)
wezterm.on("decrement-opacity", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = config.window_background_opacity - opacity_crement
    elseif overrides.window_background_opacity > 0.01 then
        overrides.window_background_opacity = overrides.window_background_opacity - opacity_crement
    end
    window:set_config_overrides(overrides)
end)
config.keys = require("configs.keys")

config.window_padding = {
    left = 5,
    right = 5,
    top = 0,
    bottom = 0,
}
-- and finally, return the configuration to wezterm
return config
