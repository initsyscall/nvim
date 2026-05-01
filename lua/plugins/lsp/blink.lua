return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    -- 1. KEYMAPS (Standard Super-Tab + Arrow Keys)
    preset = "default",
    keymap = {
      preset = "default",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
    },

    -- 2. APPEARANCE
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    -- 3. SOURCES
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- 4. COMPLETION UI & GHOST TEXT
    completion = {
      ghost_text = { enabled = false }, -- Off by default, toggleable via <leader>ug
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

    -- 5. SIGNATURE HELP (Floating Function Args)
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
  },
  opts_extend = { "sources.default" },

  -- 6. DYNAMIC CONFIGURATION & TOGGLES
  config = function(_, opts)
    local blink = require("blink.cmp")
    local ghost_enabled = opts.completion.ghost_text.enabled

    -- Setup standard config
    blink.setup(opts)

    -- Force "0.5 Opacity" look by linking to Comment highlight securely
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })
      end,
    })
    vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })

    -- Toggle Keymap (<leader>ug) for Ghost Text
    vim.keymap.set("n", "<leader>ug", function()
      ghost_enabled = not ghost_enabled
      -- Update the completion menu to reflect changes
      vim.api.nvim_set_hl(0, "BlinkCmpGhostText", ghost_enabled and { link = "Comment" } or { blend = 100 })

      local state = ghost_enabled and "Enabled" or "Disabled"
      local Snacks = package.loaded["snacks"]
      if Snacks then
        Snacks.notify.info("Ghost Text: " .. state, { title = "Blink CMP" })
      else
        vim.notify("Ghost Text: " .. state, vim.log.levels.INFO)
      end
    end, { desc = "Toggle Ghost Text (visual only)" })
  end,

}
