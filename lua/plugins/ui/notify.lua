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
  config = function(_, opts)
    require("snacks").setup(opts)
    -- Startup speed ping: lazy already times startup till UIEnter, so just
    -- surface it as one minimal notification.
    vim.api.nvim_create_autocmd("UIEnter", {
      once = true,
      callback = function()
        local ok, stats = pcall(function()
          return require("lazy.stats").stats()
        end)
        local ms = ok and stats.startuptime or 0
        if ms <= 0 then -- fallback for environments without accurate stat
          ms = (vim.uv.hrtime() - require("lazy")._start) / 1e6
        end
        vim.notify(("Neovim started in %dms"):format(math.floor(ms + 0.5)), vim.log.levels.INFO, {
          icon = "⚡",
          title = "startup",
        })
      end,
    })
  end,
}
