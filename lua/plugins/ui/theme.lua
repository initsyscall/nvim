return {
  "initsyscall/themeInitNvim",
  priority = 1000,
  config = function()
    require("themeInit").setup({ theme = "nightSyscall", transparent = true })
  end
}
