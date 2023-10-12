local wezterm = require("wezterm")
local act = wezterm.action

local function pipe()
    if wezterm.target_triple == "x86_64-apple-darwin" then
        return "7"
    else
        return "|"
    end
end
local function leader()
    if wezterm.target_triple == "x86_64-apple-darwin" then
        return "LEADER|ALT"
    else
        return "LEADER"
    end
end
return {
    -- Panes and moving
    {
        key = pipe(),
        mods = leader(),
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "z",
        mods = "LEADER",
        action = wezterm.action.TogglePaneZoomState,
    },
    -- Sync keys (like in tmux, as I have bound to leader C-x) is not yet (and not
    -- planned to be) supported: https://github.com/wez/wezterm/issues/2658
    -- Tabs
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
    {
        key = "c",
        mods = "LEADER",
        action = act.SpawnTab("CurrentPaneDomain"),
    },
    -- Opacity
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
    -- Copy Pasta
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
    { key = "7", mods = "ALT", action = wezterm.action({ SendString = "|" }) },
    { key = "/", mods = "ALT|SHIFT", action = wezterm.action({ SendString = "\\" }) },
    { key = "8", mods = "ALT", action = wezterm.action({ SendString = "[" }) },
    { key = "9", mods = "ALT", action = wezterm.action({ SendString = "]" }) },
    { key = "(", mods = "ALT|SHIFT", action = wezterm.action({ SendString = "{" }) },
    { key = ")", mods = "ALT|SHIFT", action = wezterm.action({ SendString = "}" }) },
    { key = "K", mods = "ALT", action = wezterm.action.IncreaseFontSize },
    { key = "J", mods = "ALT", action = wezterm.action.DecreaseFontSize },
    { key = "=", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment }, -- default IncreaseFontSize
    { key = "-", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment }, -- default DecreaseFontSize
    -- { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }, -- default ActivatePaneDirection="Left" (I use this in tmux)
    -- { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment }, -- default ActivatePaneDirection="Right" (I use this in tmux)
    -- Workspaces
    { key = "p", mods = "ALT", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    -- { key = 'q',          mods = 'ALT',        action = wezterm.action.ShowLauncherArgs {flags="FUZZY|WORKSPACES"} },
    {
        -- From https://github.com/wez/wezterm/issues/3542#issuecomment-1641568650
        key = "h",
        mods = "LEADER",
        action = wezterm.action_callback(function(window, pane)
            local cmd = [[
      echo "$({
        find "$HOME" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/stowfiles" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/projects" -maxdepth 1 -mindepth 1 -type d 2>/dev/null;
        find "$HOME/Documents/work/projects" -maxdepth 1 -mindepth 1 -type d 2>/dev/null;
        find "$HOME/Documents/work" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/Documents/teaching" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/Documents/work/cesm" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/Documents/other/PhD" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/Documents/presentations" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/Documents/presentations-files" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/Documents/work/2022/ats745" -maxdepth 0 -type d 2>/dev/null;
        find "/media/een023/LaCie/een023/cesm/model-runs" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/Documents/notes_papers" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/science/notes/hack-md-notes" -maxdepth 0 -type d 2>/dev/null;
        find "/cluster/projects/nn9817k/cesm/archive" -maxdepth 0 -type d 2>/dev/null;
        find "/cluster/work/users/een023/cesm/" -maxdepth 0 -type d 2>/dev/null;
        find "$HOME/model/CESM/cesm2.1.3/CESM/cime/cases" -maxdepth 1 -type d 2>/dev/null;
      })"
      ]]
            local file = io.popen(cmd)
            if file == nil then
                return 0
            end
            local output = file:read("*a")
            file:close()

            local choices = {}
            for directory in string.gmatch(output, "([^\n]+)") do
                table.insert(choices, { label = directory })
            end

            window:perform_action(
                act.InputSelector({
                    title = "Workspaces",
                    choices = choices,
                    action = wezterm.action_callback(function(window, pane, id, label)
                        if label then
                            window:perform_action(
                                act.SwitchToWorkspace({
                                    name = label:match("([^/]+)$"),
                                    spawn = {
                                        cwd = label,
                                    },
                                }),
                                pane
                            )
                        end
                    end),
                }),
                pane
            )
        end),
    },
}
