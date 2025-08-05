local colors = require("colors")
local icons = require("icons")

local cpu = sbar.add("item", {
  position = "right",
  icon = {
    string = "󰻠",
    padding_left = 5,
    font = {
      style = "Regular",
      size = 16.0,
    },
  },
  background = {
    corner_radius = 5,
    color = colors.bar.bg,
    padding_right = 2,
    padding_left = 2,
  },
  label = { drawing = true, padding_right = 5 },
  update_freq = 120,
})
-- CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
-- CPU_INFO=$(ps -eo pcpu,user)
-- CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
-- CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
--
-- CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"
--
-- sketchybar --set $NAME label="$CPU_PERCENT%"
local function cpu_update()
  local core_count = assert(io.popen("sysctl -n machdep.cpu.thread_count"):read("a"))
  local cpu_info = assert(io.popen("ps -eo pcpu,user"):read("a"))
  local batt_info = assert(file:read("a"))
  local icon = "!"
  local charge_str = ""

  if string.find(batt_info, "AC Power") then
    icon = icons.battery.charging
    charge_str = ""
  else
    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
      charge_str = charge .. " %"
      charge = tonumber(charge)
    end

    if found and charge > 80 then
      icon = icons.battery._100
    elseif found and charge > 60 then
      icon = icons.battery._75
    elseif found and charge > 40 then
      icon = icons.battery._50
    elseif found and charge > 20 then
      icon = icons.battery._25
    else
      icon = icons.battery._0
    end
  end

  cpu:set({ label = { string = charge_str } })
end

cpu:subscribe({ "routine", "power_source_change", "system_woke" }, cpu_update)
