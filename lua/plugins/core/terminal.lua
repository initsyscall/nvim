return {
  "folke/snacks.nvim",
  opts = {
    terminal = { enabled = true },
    zen = { enabled = true },
    dim = { enabled = true, scope = { min_size = 5, max_size = 20 } },
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
    { "<leader>tt", function() require("snacks").terminal.toggle(nil, { count = vim.v.count1 }) end,                  desc = "Toggle Terminal (ID)" },
    { "<leader>tf", function() require("snacks").terminal.open(nil, { win = { position = "float" } }) end,            desc = "Terminal (Float)" },
    { "<leader>gg", function() require("snacks").lazygit() end,                                                       desc = "Lazygit" },
    { "<leader>ty", function() require("snacks").terminal.toggle("yazi", { win = { style = "terminal_float" } }) end, desc = "Yazi" },
    { "<leader>z",  desc = "Zen" },
    { "<leader>zt", function() require("snacks").zen() end,                                                     desc = "True Zen Mode" },
    { "<leader>zd", function()
      local dim = require("snacks").dim
      local notify = function(msg)
        local Snacks = package.loaded["snacks"]
        if Snacks then
          Snacks.notify.info(msg)
        else
          vim.notify(msg)
        end
      end
      if dim.enabled then
        dim.disable()
        notify("Dim Off")
      else
        dim.enable()
        notify("Dim On")
      end
    end, desc = "Toggle Zen Dim" },
  }
}
