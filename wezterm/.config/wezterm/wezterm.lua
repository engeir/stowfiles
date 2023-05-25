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

config.font = wezterm.font("Recursive")
config.font_size = 11.0
config.adjust_window_size_when_changing_font_size = false
-- For example, changing the color scheme:
config.color_scheme = "Gruvbox dark, medium (base16)"
config.colors = {
    background = "#282828",
}
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.9
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
        overrides.window_background_opacity = config.window_background_opacity + 0.1
    elseif overrides.window_background_opacity < 0.95 then
        overrides.window_background_opacity = overrides.window_background_opacity + 0.1
    end
    window:set_config_overrides(overrides)
end)
wezterm.on("decrement-opacity", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = config.window_background_opacity - 0.1
    elseif overrides.window_background_opacity > 0.05 then
        overrides.window_background_opacity = overrides.window_background_opacity - 0.1
    end
    window:set_config_overrides(overrides)
end)
config.keys = {
    {
        key = "B",
        mods = "CTRL",
        action = wezterm.action.EmitEvent("toggle-opacity"),
    },
    {
        key = "a",
        mods = "ALT",
        action = wezterm.action.EmitEvent("increment-opacity"),
    },
    {
        key = "s",
        mods = "ALT",
        action = wezterm.action.EmitEvent("decrement-opacity"),
    },
    {
        key = "c",
        mods = "ALT",
        action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
    },
    {
        key = "v",
        mods = "ALT",
        action = wezterm.action.PasteFrom("Clipboard"),
    },
    { key = "K",          mods = "ALT",        action = wezterm.action.IncreaseFontSize },
    { key = "J",          mods = "ALT",        action = wezterm.action.DecreaseFontSize },
    { key = "=",          mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment }, -- default IncreaseFontSize
    { key = "-",          mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment }, -- default DecreaseFontSize
    { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }, -- default ActivatePaneDirection="Left" (I use this in tmux)
    { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }, -- default ActivatePaneDirection="Right" (I use this in tmux)
}

config.window_padding = {
    left = 5,
    right = 5,
    top = 0,
    bottom = 0,
}
-- and finally, return the configuration to wezterm
return config
