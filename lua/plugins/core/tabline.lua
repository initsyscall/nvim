return {
  "echasnovski/mini.tabline",
  version = false,
  event = "VeryLazy",
  opts = {
    show_newline_at_cursor = true,
    modified_indicator = "●",
    close_buffers = "hide",
    set_virt_lines = true,
    tabpage_prefix = false,
    formatting = {
      side = "right",
      converge = "lowercase",
    },
  },
  config = function(_, opts)
    require("mini.tabline").setup(opts)

    -- Hide tabline on No Name buffers
    vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
      callback = function()
        if vim.fn.expand("%") == "" then
          vim.o.showtabline = 0
        else
          vim.o.showtabline = 2
        end
      end,
    })
  end,
}
