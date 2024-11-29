Status:children_add(function()
  local h = cx.active.current.hovered
  if h == nil or ya.target_family() ~= "unix" then
    return ui.Line({})
  end

  return ui.Line({
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ui.Span(":"),
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    ui.Span(" "),
  })
end, 500, Status.RIGHT)

-- Git mode view
THEME.git = THEME.git or {}
THEME.git = THEME.git or {}
THEME.git.modified_sign = "M"
THEME.git.deleted_sign = "D"
THEME.git.modified = ui.Style():fg("blue")
THEME.git.deleted = ui.Style():fg("red"):bold()
require("git"):setup()
