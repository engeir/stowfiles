local wezterm = require("wezterm")

return {
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
    -- { key = "p",          mods = "ALT",        action = wezterm.action({ SendString = "\x1bp" }) },
    -- { key = "q",          mods = "ALT",        action = wezterm.action({ SendString = "\x1bq" }) },
    { key = "7",          mods = "ALT",        action = wezterm.action({ SendString = "|" }) },
    { key = "/",          mods = "ALT|SHIFT",  action = wezterm.action({ SendString = "\\" }) },
    { key = "8",          mods = "ALT",        action = wezterm.action({ SendString = "[" }) },
    { key = "9",          mods = "ALT",        action = wezterm.action({ SendString = "]" }) },
    { key = "(",          mods = "ALT|SHIFT",  action = wezterm.action({ SendString = "{" }) },
    { key = ")",          mods = "ALT|SHIFT",  action = wezterm.action({ SendString = "}" }) },
    { key = "K",          mods = "ALT",        action = wezterm.action.IncreaseFontSize },
    { key = "J",          mods = "ALT",        action = wezterm.action.DecreaseFontSize },
    { key = "=",          mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment }, -- default IncreaseFontSize
    { key = "-",          mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment }, -- default DecreaseFontSize
    { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }, -- default ActivatePaneDirection="Left" (I use this in tmux)
    { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }, -- default ActivatePaneDirection="Right" (I use this in tmux)
}
