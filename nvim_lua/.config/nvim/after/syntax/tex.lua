vim.cmd([[
syntax match texCmdRef nextgroup=texRefOpt,texRefArg skipwhite skipnl "\\[Ee]dcite[pt]\?\>\*\?"
syntax match texCmdRef nextgroup=texRefOpt,texRefArg skipwhite skipnl "\\[Tt]ranscite[pt]\?\>\*\?"
syntax match texCmdRef nextgroup=texRefOpt,texRefArg skipwhite skipnl "\\citeA[pt]\?\>\*\?"
]])
