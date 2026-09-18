local pick = function(fn, title, extra)
  extra = extra or {}
  return function()
    require("fzf-lua")[fn](vim.tbl_extend("force", extra, { winopts = { title = title } }))
  end
end

return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        preview = {
          border = "rounded",
        },
      },
      fzf_opts = {
        ["--pointer"] = "❯ ",
        ["--marker"] = "● ",
      },
      defaults = {
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.dist/",
          "%.cache/",
          "__pycache__/",
          "target/",
          "%.next/",
          "%.DS_Store",
        },
      },
    },
    keys = {
      -- find
      { "<leader>fb", pick("buffers", "Buffers"), desc = "Buffers" },
      { "<leader>fc", pick("files", "Config File", { cwd = vim.fn.stdpath("config") }), desc = "Find Config File" },
      { "<leader>ff", pick("files", "Find Files"), desc = "Find Files" },
      { "<leader>fg", pick("git_files", "Git Files"), desc = "Find Git Files" },
      { "<leader>fr", pick("oldfiles", "Recent"), desc = "Recent" },
      -- git
      { "<leader>gb", pick("git_branches", "Git Branches"), desc = "Git Branches" },
      { "<leader>gl", pick("git_commits", "Git Log"), desc = "Git Log" },
      { "<leader>gL", pick("git_bcommits", "Git Log (Line)"), desc = "Git Log Line" },
      { "<leader>gs", pick("git_status", "Git Status"), desc = "Git Status" },
      { "<leader>gS", pick("git_stash", "Git Stash"), desc = "Git Stash" },
      -- Grep
      { "<leader>sb", pick("blines", "Buffer Lines"), desc = "Buffer Lines" },
      { "<leader>sB", pick("lines", "Grep Buffers"), desc = "Grep Open Buffers" },
      { "<leader>sg", pick("live_grep", "Grep"), desc = "Grep" },
      { "<leader>sw", pick("grep_visual", "Grep Word"), desc = "Grep word/selection", mode = { "n", "x" } },
      -- search
      { '<leader>s"', pick("registers", "Registers"), desc = "Registers" },
      { "<leader>s/", pick("search_history", "Search History"), desc = "Search History" },
      { "<leader>sc", pick("command_history", "Command History"), desc = "Command History" },
      { "<leader>sC", pick("commands", "Commands"), desc = "Commands" },
      { "<leader>sd", pick("diagnostics_workspace", "Diagnostics"), desc = "Diagnostics" },
      { "<leader>sD", pick("diagnostics_doc", "Buffer Diagnostics"), desc = "Buffer Diagnostics" },
      { "<leader>sh", pick("help_tags", "Help"), desc = "Help Pages" },
      { "<leader>sH", pick("highlights", "Highlights"), desc = "Highlights" },
      { "<leader>sj", pick("jumplist", "Jumps"), desc = "Jumps" },
      { "<leader>sk", pick("keymaps", "Keymaps"), desc = "Keymaps" },
      { "<leader>sl", pick("loclist", "Location List"), desc = "Location List" },
      { "<leader>sm", pick("marks", "Marks"), desc = "Marks" },
      { "<leader>sM", pick("man_pages", "Man Pages"), desc = "Man Pages" },
      { "<leader>sq", pick("quickfix", "Quickfix"), desc = "Quickfix List" },
      { "<leader>sR", pick("resume", "Resume"), desc = "Resume" },
      { "<leader>su", pick("undotree", "Undo History"), desc = "Undo History" },
      { "<leader>uC", pick("colorschemes", "Colorschemes"), desc = "Colorschemes" },
      -- LSP
      { "gd", pick("lsp_definitions", "Goto Definition"), desc = "Goto Definition" },
      { "gD", pick("lsp_declarations", "Goto Declaration"), desc = "Goto Declaration" },
      { "gr", pick("lsp_references", "References"), nowait = true, desc = "References" },
      { "gI", pick("lsp_implementations", "Goto Implementation"), desc = "Goto Implementation" },
      { "gy", pick("lsp_typedefs", "Goto Type Definition"), desc = "Goto T[y]pe Definition" },
      { "<leader>ss", pick("lsp_document_symbols", "Symbols"), desc = "LSP Symbols" },
      { "<leader>sS", pick("lsp_workspace_symbols", "Workspace Symbols"), desc = "LSP Workspace Symbols" },
    },
  },
}