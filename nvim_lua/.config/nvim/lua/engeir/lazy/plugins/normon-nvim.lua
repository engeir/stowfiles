return {
  "jake-stewart/normon.nvim",
  config = function()
    local normon = require("normon")
    -- cgn on current word/selection
    normon("gy", "cgn")
    normon("gY", "cgN")
  end,
}
