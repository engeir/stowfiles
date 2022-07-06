local ok, comment = pcall(require, "Comment")
if not ok then
    return
end

comment.setup()

local ft = require("Comment.ft")
ft.set("ncl", ";%s")
