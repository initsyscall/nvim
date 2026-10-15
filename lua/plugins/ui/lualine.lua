return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    local lsp_servers = function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then return '' end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return table.concat(names, '|')
    end

    require('lualine').setup({
      options = {
        globalstatus = true,
        theme = require('themeInit').get_lualine_theme(),
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 1, file_status = true } },
        lualine_c = {}, -- no default filename here; b already shows the path
        lualine_x = { lsp_servers },
        lualine_y = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = {
              error = '■ Err ',
              warn = '▲ Warn ',
              info = '◆ Info ',
              hint = ' Hint ',
            },
            diagnostics_color = {
              error = 'DiagnosticError',
              warn = 'DiagnosticWarn',
              info = 'DiagnosticInfo',
              hint = 'DiagnosticHint',
            },
            separator = ' | ',
          },
          'location',
        },
        lualine_z = {},
      },
    })
  end,
}
