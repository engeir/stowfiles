return {
  "saghen/blink.pairs",
  version = "*",
  dependencies = "saghen/blink.download",

  --- @module 'blink.pairs'
  --- @type blink.pairs.Config
  opts = {
    mappings = {
      -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
      enabled = true,
      -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
      pairs = {},
    },
    highlights = {
      enabled = true,
      groups = {
        "BlinkPairsOrange",
        "BlinkPairsPurple",
        "BlinkPairsBlue",
      },
      matchparen = {
        enabled = true,
        group = "MatchParen",
      },
    },
    debug = false,
  },
}
