return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix", -- Modern, clean aesthetic
    spec = {
       { "<leader>w", group = "󰆓 Write" },
       { "<leader>f", group = "Find" },
       { "<leader>g", group = "Git" },
       { "<leader>s", group = "Search" },
       { "<leader>d", group = "Debugger" },
       { "<leader>c", group = "Code" },
       { "<leader>b", group = "Buffer" },
       { "<leader>e", group = "Explorer" },
       { "<leader>m", group = "MiniExplorer" },
       { "<leader>t", group = "Terminal" },
       { "<leader>u", group = "UI" },
       { "<leader>r", group = " Runner" },
       { "<leader>q", group = "Quit" },
    },
  },
}
