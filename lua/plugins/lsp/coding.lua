

return {
  -- 1. AUTO PAIRS
  { "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },

  -- 2. SURROUND
  {
    "echasnovski/mini.surround",
    keys = {
      { "gsa", mode = { "n", "v" }, desc = "Add Surrounding" },
      { "gsd",                      desc = "Delete Surrounding" },
      { "gsf",                      desc = "Find Right Surrounding" },
      { "gsF",                      desc = "Find Left Surrounding" },
      { "gsh",                      desc = "Highlight Surrounding" },
      { "gsr",                      desc = "Replace Surrounding" },
      { "gsn",                      desc = "Update Surrounding Lines" },
    },
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },

  -- 3. FORMATTING (Conform.nvim)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Changed to standard table so user/overrides.lua can deep-merge formatters
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = function(bufnr)
        local settings = require("config.lsp").options.lsp.formatting
        if settings.format_on_save then
          return { timeout_ms = settings.timeout_ms, lsp_fallback = true }
        end
        return false
      end,
    },
  },
}
