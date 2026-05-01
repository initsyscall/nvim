
return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_prev_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        },
      },
    },
    config = function(_, opts)
      -- CRASH PROTECTION: Use pcall to load the config
      -- If treesitter is broken, this prevents Neovim from failing to start.
      local status, ts = pcall(require, "nvim-treesitter.configs")

      if not status then
        -- Silently fail or notify if you want to know
        -- vim.notify("Treesitter failed to load. Run :TSUpdate", vim.log.levels.WARN)
        return
      end

      ts.setup(opts)
    end,
  },

  -- Auto-close tags (HTML/JSX)
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  { import = "plugins.lsp.treesitter.context" },
}
