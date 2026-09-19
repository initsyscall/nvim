return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    notifier = {
      enabled = true,
      style = "compact", -- rounded border with centered icon/title
      gap = 1,           -- breathing room between stacked notifications
      margin = { top = 2, right = 2, bottom = 0 },
      width = { min = 42, max = 0.4 },
      icons = {
        error = " ", -- cod-error
        warn  = " ", -- cod-warning
        info  = " ", -- cod-info
        debug = " ", -- cod-bug
        trace = "󰋽 ", -- md-information_outline
      },
    },
  },
}
