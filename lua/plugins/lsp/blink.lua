return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    -- Keymaps
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
    },

    -- Appearance
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    -- Sources
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- Completion & ghost text
    completion = {
      ghost_text = { enabled = true },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
      menu = {
        border = "rounded",
        auto_show = true,
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
        },
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
    },

    -- Signature help
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
  },
  opts_extend = { "sources.default" },

  config = function(_, opts)
    local blink = require("blink.cmp")
    local ghost_enabled = opts.completion.ghost_text.enabled

    blink.setup(opts)

    -- Ghost text styled via the Comment highlight
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })
      end,
    })
    vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })

    vim.keymap.set("n", "<leader>ug", function()
      ghost_enabled = not ghost_enabled
      vim.api.nvim_set_hl(0, "BlinkCmpGhostText", ghost_enabled and { link = "Comment" } or { link = "Normal" })
      require("util").notify("Ghost Text: " .. (ghost_enabled and "Enabled" or "Disabled"), "Blink CMP")
    end, { desc = "Toggle Ghost Text (visual only)" })
  end,

}
