-- awesome theme: gruvbox palette (from mango config.conf)

local theme = {}

theme.font = "CaskaydiaMono Nerd Font Bold 10"

local bg       = "#201b14"
local fg       = "#D1B88E"
local orange   = "#DA7510"
local red      = "#ad401f"
local grey     = "#444444"
local occupied = "#2a2318"
local fg_dim   = "#ddca9e"
local focus_c  = "#c9b890"

theme.bg_normal   = bg
theme.bg_focus    = orange
theme.bg_urgent   = red
theme.bg_minimize = occupied
theme.bg_systray  = bg

theme.fg_normal   = fg
theme.fg_focus    = bg
theme.fg_urgent   = fg_dim
theme.fg_minimize = fg_dim

theme.useless_gap  = 5
theme.border_width = 3
theme.border_normal = "#2a2318"
theme.border_focus  = orange
theme.border_marked = red

-- Taglist
theme.taglist_bg_focus    = orange
theme.taglist_fg_focus    = bg
theme.taglist_bg_urgent   = red
theme.taglist_fg_urgent   = fg_dim
theme.taglist_bg_occupied = occupied
theme.taglist_fg_occupied = focus_c
theme.taglist_bg_empty    = bg
theme.taglist_fg_empty    = grey
theme.taglist_bg_volatile = red
theme.taglist_fg_volatile = fg_dim

-- Tasklist
theme.tasklist_bg_normal = bg
theme.tasklist_fg_normal = fg
theme.tasklist_bg_focus  = bg
theme.tasklist_fg_focus  = orange
theme.tasklist_align     = "center"

-- Wibar
theme.wibar_bg     = bg
theme.wibar_fg     = fg
theme.wibar_height = 24

-- Titlebar (not used, but avoids errors)
theme.titlebar_bg_focus  = orange
theme.titlebar_bg_normal = bg

-- No titlebar icons needed
theme.titlebar_close_button_normal = ""
theme.titlebar_close_button_focus  = ""

return theme
