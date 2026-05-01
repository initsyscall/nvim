return {
  -- mini.icons for file icons (used by Neo-tree and Mini.files)
  {
    'echasnovski/mini.icons',
    version = false,
    priority = 1000, -- Load before other plugins
    config = function()
      -- Setup mini.icons and mock nvim-web-devicons so Neo-tree uses it
      require('mini.icons').setup()
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },
}
