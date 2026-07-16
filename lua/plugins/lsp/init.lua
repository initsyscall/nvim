return {
  { "folke/lazydev.nvim", ft = "lua", opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local config = require("config.lsp").options

      -- [A] CRASH PROTECTION: Safely load Blink capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- [B] Detect Environment (Termux requires special Mason paths)
      local is_termux = vim.fn.exists("$TERMUX_VERSION") == 1

      -- [C] MASON SETUP
      require("mason").setup({
        ui = { border = "rounded" },
        install_root_dir = is_termux and vim.fn.expand("$HOME/.local/share/nvim/mason") or nil,
      })

      -- [D] EXTRACT SERVERS (Bulletproofed for Array or Dictionary formats)
      local active_servers = {}
      local seen = {} -- Prevent duplicates if mixed formats occur

      for k, v in pairs(config.lsp.servers or {}) do
        local server_name = nil

        -- If it's the NEW dictionary format: `pyright = true`
        if type(k) == "string" and v == true then
          server_name = k
          -- If it's the OLD array format: `"pyright"`
        elseif type(k) == "number" and type(v) == "string" then
          server_name = v
        end

        if server_name and not seen[server_name] then
          table.insert(active_servers, server_name)
          seen[server_name] = true
        end
      end

      -- [E] MASON-LSPCONFIG
      require("mason-lspconfig").setup({
        ensure_installed = not is_termux and active_servers or {},
        automatic_installation = not is_termux,
        handlers = {
          function(server_name)
            -- Only attempt start if binary exists (Protects Termux users)
            if not is_termux or vim.fn.executable(server_name) == 1 then
              require("lspconfig")[server_name].setup({
                capabilities = capabilities,
              })
            end
          end,
        },
      })

      -- [F] LSP ATTACH LOGIC
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("aether_lsp_attach", { clear = true }),
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
        end,
      })

      -- Prettify Icons
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },
}
