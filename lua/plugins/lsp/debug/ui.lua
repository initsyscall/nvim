return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    -- Toggle full UI (bottom + left)
    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle Full UI" },
    -- Toggle left sidebar only
    { "<leader>dN", function() require("dapui").toggle({ layout = 1 }) end, desc = "Toggle NASA Sidebar" },
    -- Eval expression under cursor
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval Under Cursor" },
  },
  opts = {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
      }
    },
    floating = { border = "rounded", mappings = { close = { "q", "<Esc>" } } },
    icons = { collapsed = "", current_frame = "", expanded = "" },

    -- LAYOUT DEFINITIONS
    layouts = {
      -- Left sidebar (NASA mode)
      {
        elements = {
          { id = "scopes",      size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks",      size = 0.25 },
          { id = "watches",     size = 0.25 },
        },
        position = "left",
        size = 40,
      },
      -- Bottom console
      {
        elements = {
          { id = "repl",    size = 0.5 },
          { id = "console", size = 0.5 },
        },
        position = "bottom",
        size = 10,
      },
    },
  },
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup(opts)

    -- Auto-open the bottom console when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({ layout = 2 })
    end
  end,
}
