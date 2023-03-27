local Color, colors, Group, groups, styles = require("colorbuddy").setup()

-- Use Color.new(<name>, <#rrggbb>) to create new colors
-- They can be accessed through colors.<name>
Color.new("background", "#282c34")
Color.new("red", "#cc6666")
Color.new("green", "#99cc99")
Color.new("yellow", "#f0c674")

-- Define highlights in terms of `colors` and `groups`
Group.new("Function", colors.yellow, colors.background, styles.bold)
Group.new("luaFunctionCall", groups.Function, groups.Function, groups.Function)

-- Define highlights in relative terms of other colors
Group.new("Error", colors.red:light(), nil, styles.bold)

-- require("colorbuddy").setup()

Color.new("white", "#f2e5bc")
Color.new("red", "#cc6666")
Color.new("pink", "#fef601")
Color.new("green", "#99cc99")
Color.new("yellow", "#f8fe7a")
Color.new("blue", "#81a2be")
Color.new("aqua", "#8ec07c")
Color.new("cyan", "#8abeb7")
Color.new("purple", "#8e6fbd")
Color.new("violet", "#b294bb")
Color.new("orange", "#de935f")
Color.new("brown", "#a3685a")

Color.new("seagreen", "#698b69")
Color.new("turquoise", "#698b69")
