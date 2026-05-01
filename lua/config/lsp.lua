local M = {}

M.options = {
  lsp = {
    servers = {
      lua_ls = true,
      pyright = true,
      ts_ls = true,
    },
    formatting = {
      format_on_save = true,
      timeout_ms = 1000,
    },
  },
}

function M.setup(user_config)
  M.options = vim.tbl_deep_extend("force", M.options, user_config or {})
end

return M
