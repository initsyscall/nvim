return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach", -- Load only when LSP is active
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "modern", -- "modern", "classic", "powerline", "ghost", "simple", "nonerdfont"
      hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine", -- Blends with the line highlight
        mixing_color = "None",
      },
      options = {
        show_source = true,  -- Show "lua_ls" or "eslint"
        use_icons_from_diagnostic = true,
        add_messages = true, -- Show the error message
        throttle = 20,       -- Performance throttling
        softwrap = 30,       -- Wrap long error messages

        -- VISUAL POSITIONING
        multilines = true,
        show_all_diags_on_cursorline = true,
        enable_on_insert = false, -- Keep insert mode clean

        virt_texts = {
          priority = 2048,
        },
      },
    })

    -- Disable default virtual text since we are using bubbles
    vim.diagnostic.config({ virtual_text = false })
  end,
}
