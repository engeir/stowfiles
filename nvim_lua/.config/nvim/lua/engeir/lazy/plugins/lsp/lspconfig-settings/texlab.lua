local util = require("lspconfig.util")
vim.g.texlab_auto_build = false
local wk = require("which-key")

local function buf_clean(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local texlab_client = util.get_active_client_by_name(bufnr, "texlab")
  local params = {
    command = "texlab.cleanArtifacts",
    arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
  }
  if texlab_client then
    texlab_client.request("workspace/executeCommand", params, function(err, _)
      if err then
        error(tostring(err))
      end
    end, bufnr)
  else
    print(
      "method workspace/executeCommand is not supported by any servers active on the current buffer"
    )
  end
end

local function buf_show_dep_graph(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local texlab_client = util.get_active_client_by_name(bufnr, "texlab")
  local params = {
    command = "texlab.showDependencyGraph",
    -- arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
  }
  if texlab_client then
    texlab_client.request("workspace/executeCommand", params, function(err, result)
      if err then
        error(tostring(err))
      end
      print(result.status)
    end, bufnr)
  else
    print(
      "method workspace/executeCommand is not supported by any servers active on the current buffer"
    )
  end
end

return {
  -- https://github.com/latex-lsp/texlab/wiki/Configuration
  settings = {
    texlab = {
      chktex = {
        onEdit = false,
        onOpenAndSave = true,
      },
      diagnostics = {
        ignoredPatterns = {
          "Underfull",
          "Overfull",
        },
      },
      experimental = {
        followPackageLinks = true,
        citationCommands = {
          "citeA",
        },
        labelReferenceCommands = {
          "subref",
        },
        mathEnvironments = {
          "align*",
          "equation",
        },
      },
      formatterLineLength = -1, -- bib files
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
      latexindent = { modifyLineBreaks = true },
      build = {
        onSave = false, -- i'd rather control this with autocommands, so i can more easily toggle it
        forwardSearchAfter = false,
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
      },
    },
  },
  commands = {
    TexlabClean = {
      function()
        buf_clean(0)
      end,
      description = "Clean the texlab artifacts",
    },
    TexlabShowDepGraph = {
      function()
        buf_show_dep_graph(0)
      end,
      description = "Show the texlab dependency graph",
    },
    TexlabBuildToggle = {
      function()
        vim.g.texlab_auto_build = not vim.g.texlab_auto_build
      end,
      description = "Toggle the auto build feature for texlab",
    },
  },
  on_attach = function(_, bufnr)
    wk.add({
      { "<localleader>t", group = "Texlab" },
      {
        "<localleader>ta",
        "<cmd>TexlabBuildToggle<cr>",
        buffer = bufnr,
        desc = "Toggle auto building (Texlab)",
      },
      {
        "<localleader>tb",
        "<cmd>TexlabBuild<cr>",
        buffer = bufnr,
        desc = "Build doc (Texlab)",
      },
      {
        "<localleader>tv",
        "<cmd>TexlabForward<cr>",
        buffer = bufnr,
        desc = "Forward search doc (Texlab)",
      },
    })
    -- Set up keymap that forward searches
    -- vim.keymap.set(
    --   "n",
    --   "<localleader>ta",
    --   "<cmd>TexlabBuildToggle<CR>",
    --   { buffer = bufnr, desc = "Texlab toggle auto building" }
    -- )
    -- vim.keymap.set(
    --   "n",
    --   "<localleader>tb",
    --   "<cmd>TexlabBuild<CR>",
    --   { buffer = bufnr, desc = "Texlab build doc" }
    -- )
    -- vim.keymap.set(
    --   "n",
    --   "<localleader>tv",
    --   "<cmd>TexlabForward<CR>",
    --   { buffer = bufnr, desc = "Texlab forward search doc" }
    -- )
  end,
}
