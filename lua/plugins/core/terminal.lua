return {
  "folke/snacks.nvim",
  opts = {
    terminal = { enabled = true },
    styles = {
      terminal = {
        bo = { filetype = "snacks_terminal" },
        stack = true,
        wo = {
          winhighlight =
          "Normal:Normal,NormalNC:Normal,WinBar:Normal,WinBarNC:Normal,SignColumn:Normal,CursorLine:Normal",
          cursorline = false,
          number = false,
          relativenumber = false,
          signcolumn = "no",
          list = false,
        },
        keys = { q = "hide" },
      },
      terminal_float = {
        position = "float",
        border = "rounded",
        width = 0.9,
        height = 0.9,
        backdrop = false,
        wo = {
          winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat,FloatBorder:FloatBorder,CursorLine:NormalFloat",
          cursorline = false,
        },
      },
    },
  },
  keys = {
    { "<leader>tt", function() Snacks.terminal.toggle(nil, { count = vim.v.count1 }) end,                  desc = "Toggle Terminal (ID)" },
    { "<leader>tf", function() Snacks.terminal.open(nil, { win = { position = "float" } }) end,            desc = "Terminal (Float)" },
    { "<leader>gg", function() Snacks.lazygit() end,                                                       desc = "Lazygit" },
    { "<leader>ty", function() Snacks.terminal.toggle("yazi", { win = { style = "terminal_float" } }) end, desc = "Yazi" },
  }
}
