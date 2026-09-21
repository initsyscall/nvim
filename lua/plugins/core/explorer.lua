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
          -- netrw navigation: h = parent, l = enter/open, L = cd + re-root
          ["h"] = "navigate_up",
          ["l"] = "open",
          ["L"] = "set_root",
        },
      },
    },
  },
}