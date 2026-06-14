return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        preview = {
          border = "rounded",
        },
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
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>fc", function()
          require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
        end, desc = "Find Config File" },
      { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find Files" },
      { "<leader>fg", function() require("fzf-lua").git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent" },
      -- folders only (excludes .git, .dist, node_modules, etc.)
      { "<leader>fd", function()
          local fzf_lua = require("fzf-lua")
          fzf_lua.files({
            fd_opts = "--type d --hidden --follow --exclude .git --exclude node_modules --exclude .dist --exclude .cache --exclude __pycache__ --exclude target --exclude .next",
            file_icons = false,
            actions = {
              ["default"] = function(selected, _)
                if #selected == 0 then return end
                local path = vim.fn.fnamemodify(selected[1], ":p")
                require("neo-tree.command").execute({ toggle = true, dir = path })
              end,
            },
          })
        end, desc = "Find Folders" },
      -- git
      { "<leader>gb", function() require("fzf-lua").git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() require("fzf-lua").git_commits() end, desc = "Git Log" },
      { "<leader>gL", function() require("fzf-lua").git_bcommits() end, desc = "Git Log Line" },
      { "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git Status" },
      { "<leader>gS", function() require("fzf-lua").git_stash() end, desc = "Git Stash" },
      -- Grep
      { "<leader>sb", function() require("fzf-lua").blines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() require("fzf-lua").lines() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() require("fzf-lua").live_grep() end, desc = "Grep" },
      { "<leader>sw", function() require("fzf-lua").grep_visual() end, desc = "Grep word/selection", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() require("fzf-lua").registers() end, desc = "Registers" },
      { "<leader>s/", function() require("fzf-lua").search_history() end, desc = "Search History" },
      { "<leader>sc", function() require("fzf-lua").command_history() end, desc = "Command History" },
      { "<leader>sC", function() require("fzf-lua").commands() end, desc = "Commands" },
      { "<leader>sd", function() require("fzf-lua").diagnostics_workspace() end, desc = "Diagnostics" },
      { "<leader>sD", function() require("fzf-lua").diagnostics_doc() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() require("fzf-lua").help_tags() end, desc = "Help Pages" },
      { "<leader>sH", function() require("fzf-lua").highlights() end, desc = "Highlights" },
      { "<leader>sj", function() require("fzf-lua").jumplist() end, desc = "Jumps" },
      { "<leader>sk", function() require("fzf-lua").keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() require("fzf-lua").loclist() end, desc = "Location List" },
      { "<leader>sm", function() require("fzf-lua").marks() end, desc = "Marks" },
      { "<leader>sM", function() require("fzf-lua").man_pages() end, desc = "Man Pages" },
      { "<leader>sq", function() require("fzf-lua").quickfix() end, desc = "Quickfix List" },
      { "<leader>sR", function() require("fzf-lua").resume() end, desc = "Resume" },
      { "<leader>su", function() require("fzf-lua").undotree() end, desc = "Undo History" },
      { "<leader>uC", function() require("fzf-lua").colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() require("fzf-lua").lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() require("fzf-lua").lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() require("fzf-lua").lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() require("fzf-lua").lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() require("fzf-lua").lsp_typedefs() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() require("fzf-lua").lsp_document_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    },
  },
}
