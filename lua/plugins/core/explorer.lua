return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
  },
  opts = {
    -- Single pane, netrw-style: the tree takes over the current window
    window = {
      position = "current",
    },
    filesystem = {
      window = {
        mappings = {
          -- h = collapse dir, H = up one level (no cd), l = enter/open, L = cd + re-root
          ["h"] = "close_node",
          ["H"] = function(state)
            local bind = state.bind_to_cwd
            state.bind_to_cwd = false -- navigate up without changing cwd
            state.commands.navigate_up(state)
            state.bind_to_cwd = bind
          end,
          ["l"] = "open",
          ["L"] = "set_root",
        },
      },
    },
  },
}