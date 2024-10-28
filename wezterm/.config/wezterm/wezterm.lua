-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will help provide clearer
-- error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
-- Spawn a fish shell in login mode
-- config.default_prog = { "/usr/bin/fish", "-l" }

-- This is where you actually apply your config choices
wezterm.on("update-right-status", function(window, pane)
  -- window:set_right_status()
  -- local cmd = [[wezterm cli list --format json | jq '.[] | .workspace']]
  -- local workspace = io.popen(cmd)
  -- if workspace == nil then
  --     return 0
  -- end
  -- local leader = workspace:read("*a")
  -- workspace:close()
  local leader = window:active_workspace()
  if window:leader_is_active() then
    leader = leader .. "  LEADER"
  end
  window:set_right_status(leader)
end)
-- From https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    local cmd = { "despell", title }
    local handle = io.popen(table.concat(cmd, " "))
    if handle == nil then
      return title
    end
    local result = handle:read("*a")
    return result .. title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  local active_title = tab_info.active_pane.title
  local cmd = { "despell", active_title }
  local handle = io.popen(table.concat(cmd, " "))
  if handle == nil then
    return active_title
  end
  local result = handle:read("*a")
  return active_title .. " " .. result
  -- return " " .. tab_info.active_pane.title .. " "
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  if tab.is_active then
    return {
      { Background = { Color = "blue" } },
      { Text = " " .. title .. " " },
    }
  end
  return title
end)
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

-- config.window_decorations = "TITLE"
config.audible_bell = "Disabled"
-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font = wezterm.font("CaskaydiaMono Nerd Font Mono")
local font_size
if wezterm.target_triple == "x86_64-apple-darwin" then
  font_size = 14
else
  font_size = 11.0
end
config.font_size = font_size
config.initial_rows = 50
config.initial_cols = 80
config.adjust_window_size_when_changing_font_size = false
-- For example, changing the color scheme:
-- This affects the colors reported/used by `pastel`, so is seems better to set
-- LS_COLORS and not the theme.
-- config.color_scheme = "Gruvbox dark, medium (base16)"
config.colors = {
  compose_cursor = "orange",
  background = "#2d2d2d",
}
config.window_background_gradient = require("configs.window_background_gradient")
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
    overrides.window_background_opacity = config.window_background_opacity
      + opacity_crement
  elseif overrides.window_background_opacity < 0.99 then
    overrides.window_background_opacity = overrides.window_background_opacity
      + opacity_crement
  end
  window:set_config_overrides(overrides)
end)
wezterm.on("decrement-opacity", function(window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = config.window_background_opacity
      - opacity_crement
  elseif overrides.window_background_opacity > 0.01 then
    overrides.window_background_opacity = overrides.window_background_opacity
      - opacity_crement
  end
  window:set_config_overrides(overrides)
end)
config.leader = { key = "a", mods = "CTRL" }
config.keys = require("configs.keys")
for _, key in ipairs(require("configs.smart-splits")) do
  table.insert(config.keys, key)
end

config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}

config.ssh_domains = require("configs.ssh")

-- and finally, return the configuration to wezterm
return config
