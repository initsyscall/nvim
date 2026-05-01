

return {
  -- 1. AUTO PAIRS
  { "echasnovski/mini.pairs", event = "VeryLazy", opts = {} },

  -- 2. SURROUND
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add Surrounding",         mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete Surrounding" },
        { opts.mappings.find,           desc = "Find Right Surrounding" },
        { opts.mappings.find_left,      desc = "Find Left Surrounding" },
        { opts.mappings.highlight,      desc = "Highlight Surrounding" },
        { opts.mappings.replace,        desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update Surrounding Lines" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
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
