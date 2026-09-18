local M = {}

M.options = {
  lsp = {
    servers = {
      lua_ls = true,
      pyright = true,
    },
    -- rustaceanvim (Rust LSP/DAP): set enabled = false to disable the whole feature
    rust = {
      enabled = true,
    },
    formatting = {
      format_on_save = true,
      timeout_ms = 1000,
    },
  },
}

return M
