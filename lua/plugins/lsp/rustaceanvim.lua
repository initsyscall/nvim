local options = require("config.lsp").options
if not (options.lsp.rust or {}).enabled then
  return {}
end

return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  init = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_blink, blink = pcall(require, "blink.cmp")
    if has_blink then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    local cfg = require("rustaceanvim.config")
    local mason_codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
    local codelldb_path = mason_codelldb .. "/adapter/codelldb"
    local liblldb_path = mason_codelldb .. "/lldb/lib/liblldb.so"

    vim.g.rustaceanvim = {
      tools = {
        float_win_config = { border = "rounded" },
        code_actions = { ui_select_fallback = true },
        test_runner = { type = "background" },
      },
      server = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, desc = "Rust: " .. desc })
          end

          -- cargo / clippy / diagnostics
          map("<leader>Rr", "<cmd>RustLsp runnables<cr>", "Run")
          map("<leader>Rd", "<cmd>RustLsp debug<cr>", "Debug (codelldb)")
          map("<leader>Rt", "<cmd>RustLsp testables<cr>", "Run Tests")
          map("<leader>Rc", "<cmd>RustLsp flyCheck<cr>", "Check (clippy)")
          map("<leader>Re", "<cmd>RustLsp explainError<cr>", "Explain Error")
          map("<leader>Rg", "<cmd>RustLsp renderDiagnostic<cr>", "Render Diagnostic")

          -- editing
          map("<leader>Ra", "<cmd>RustLsp codeAction<cr>", "Code Action (grouped)")
          map("<leader>Rs", "<cmd>RustLsp ssr<cr>", "Structural Search Replace")
          map("<leader>Rf", "<cmd>RustFmt<cr>", "Format (rustfmt)")

          -- navigation / info
          map("K", "<cmd>RustLsp hover actions<cr>", "Hover Actions")
          map("<leader>Rh", "<cmd>RustLsp hover actions<cr>", "Hover Actions")
          map("<leader>Rk", "<cmd>RustLsp openCargo<cr>", "Open Cargo.toml")

          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
        default_settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
              invokeLocation = "workspace",
            },
            procMacro = { enable = true },
            hover = { actions = { enable = true } },
            completion = { fullFunctionSignatures = true },
            files = { excludeDirs = { "target" } },
          },
        },
      },
      dap = {
        autoload_configurations = true,
        adapter = function()
          if vim.fn.filereadable(codelldb_path) == 1 then
            return cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
          else
            vim.notify("codelldb not installed. Run :MasonInstall codelldb", vim.log.levels.WARN)
            return false
          end
        end,
      },
    }
  end,
}
