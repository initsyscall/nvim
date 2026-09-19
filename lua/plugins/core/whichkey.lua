return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix", -- Modern, clean aesthetic
    spec = {
       { "<leader>w", group = "Write", icon = { icon = "󰆓", color = "yellow" } },
       { "<leader>f", group = "Find", icon = { icon = "󰀂", color = "green" } },
       { "<leader>s", group = "Search", icon = { icon = "󰀂", color = "green" } },
       { "<leader>g", group = "Git", icon = { icon = "󰊢", color = "yellow" } },
       { "<leader>d", group = "Debugger", icon = { icon = "󰃤", color = "red" } },
       { "<leader>c", group = "Code", icon = { icon = "󰄡", color = "orange" } },
       { "<leader>b", group = "Buffer", icon = { icon = "󰈔", color = "purple" } },
       { "<leader>e", group = "Explorer", icon = { icon = "󰙅", color = "purple" } },
       { "<leader>n", group = "Explorer", icon = { icon = "󰙅", color = "purple" } },
       { "<leader>t", group = "Terminal", icon = { icon = "", color = "red" } },
       { "<leader>u", group = "UI", icon = { icon = "󰙵", color = "cyan" } },
       { "<leader>r", group = "Runner", icon = { icon = "", color = "cyan" } },
       { "<leader>R", group = "Rust", icon = { icon = "󱘗", color = "orange" } },
       { "<leader>z", group = "Zen", icon = { icon = "", color = "cyan" } },
    },
  },
}
