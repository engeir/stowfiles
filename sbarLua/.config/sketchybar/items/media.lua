local whitelist = { ["Spotify"] = true, ["Music"] = true }

local media = sbar.add("item", {
  icon = {
    drawing = true,
    font = {
      family = "sketchybar-app-font",
      style = "Regular",
      size = "11",
    },
    y_offset = -1,
    string = ":music:",
  },
  position = "center",
  updates = true,
})

media:subscribe("media_change", function(env)
  if whitelist[env.INFO.app] then
    local creator = env.INFO.artist
    local album = ""
    if creator == "" then
      creator = env.INFO.album
    else
      album = " (" .. env.INFO.album .. ")"
    end
    media:set({
      drawing = (env.INFO.state == "playing") and true or false,
      label = creator .. ": " .. env.INFO.title .. album,
    })
  end
end)
