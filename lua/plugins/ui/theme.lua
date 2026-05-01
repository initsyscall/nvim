return {
  "initsyscall/themeInitNvim",
  url = "https://codeberg.org/initsyscall/themeInitNvim",
  priority = 1000,
  config = function()
    require("themeInit").setup({ theme = "nightSyscall" })
  end
}
