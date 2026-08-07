return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "jbyuki/one-small-step-for-vimkind",
  },
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                         desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,                                  desc = "Continue/Start" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,                             desc = "Run to Cursor" },
    { "<leader>di", function() require("dap").step_into() end,                                 desc = "Step Into" },
    { "<leader>do", function() require("dap").step_out() end,                                  desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end,                                 desc = "Step Over" },
    { "<leader>dt", function() require("dap").terminate() end,                                 desc = "Terminate" },
  },
  config = function()
    local dap = require("dap")

    -- 1. COSMETICS (The Icons)
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    local icons = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = { " ", "DiagnosticInfo" },
      BreakpointCondition = { " ", "DiagnosticInfo" },
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = { ".>", "DiagnosticInfo" },
    }
    for name, sign in pairs(icons) do
      vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[3] })
    end

    -- 2. AUTOMATION (Mason Integration)
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "python", "codelldb" },
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,

        -- FIX 1: Ensure Python allows user input
        python = function(config)
          for _, c in ipairs(config.configurations or {}) do
            c.console = "integratedTerminal"
          end
          require('mason-nvim-dap').default_setup(config)
        end,

        -- FIX 2: Ensure C/C++/Rust allows user input
        codelldb = function(config)
          require('mason-nvim-dap').default_setup(config)
          local last_build_cmd, last_bin_path = {}, {}
          local function smart_compile_and_run(lang)
            local cwd = vim.fn.getcwd()
            local default_cmd = last_build_cmd[cwd] or ""
            if default_cmd == "" then
              if lang == "rust" and vim.fn.filereadable("Cargo.toml") == 1 then
                default_cmd = "cargo build"
              elseif lang == "c" then
                default_cmd = "gcc -g *.c -o main"
              elseif lang == "cpp" then
                default_cmd = "g++ -g *.cpp -o main"
              end
            end
            local build_cmd = vim.fn.input('1. Build cmd (empty to skip): ', default_cmd)
            if build_cmd ~= "" then
              last_build_cmd[cwd] = build_cmd
              vim.notify("Compiling: " .. build_cmd, vim.log.levels.INFO)
              local out = vim.fn.system(build_cmd)
              if vim.v.shell_error ~= 0 then
                vim.notify("Build failed!\n" .. out, vim.log.levels.ERROR)
                return dap.ABORT
              end
            end
            local default_bin = last_bin_path[cwd] or (cwd .. '/')
            if not last_bin_path[cwd] and lang == "rust" and vim.fn.filereadable("Cargo.toml") == 1 then
              default_bin = cwd .. "/target/debug/"
            end
            local bin_path = vim.fn.input('2. Path to executable: ', default_bin, 'file')
            if bin_path ~= "" then
              last_bin_path[cwd] = bin_path
              return bin_path
            end
            return dap.ABORT
          end
          local smart_config = function(lang)
            return {
              {
                name = "Smart Compile & Debug",
                type = "codelldb",
                request = "launch",
                program = function() return smart_compile_and_run(lang) end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                terminal = "integrated",
              }
            }
          end
          dap.configurations.c = smart_config("c")
          dap.configurations.cpp = smart_config("cpp")
          -- rust is managed by rustaceanvim; don't override it here
          if not package.loaded["rustaceanvim"] then
            dap.configurations.rust = smart_config("rust")
          end
        end,
      },
    })

    -- 3. VIRTUAL TEXT SETUP
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      display_callback = function(variable, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
      virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
    })
    -- 4. STANDARD LUA DEBUGGER
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/local-lua-debugger-vscode/"
    local adapter_js = mason_path .. "extension/debugAdapter.js"
    if vim.fn.filereadable(adapter_js) == 0 then
      adapter_js = mason_path .. "extension/extension/debugAdapter.js"
    end
    dap.adapters.local_lua = {
      type = "executable",
      command = "node",
      args = { adapter_js },
      enrich_config = function(config, on_config)
        if not config.extensionPath then
          local c = vim.deepcopy(config)
          c.extensionPath = mason_path .. "extension/"
          on_config(c)
        else
          on_config(config)
        end
      end,
    }

    dap.configurations.lua = {
      {
        name = 'Run Current File (Local Lua)',
        type = 'local_lua',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = { lua = 'lua', file = '${file}' },
        args = {},
      },
    }
  end,
}
