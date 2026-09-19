return {
  -- mini.icons for file icons
  {
    "echasnovski/mini.icons",
    version = false,
    priority = 1000, -- load before other plugins
    config = function()
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },
}