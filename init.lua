-- Neovim version check
if vim.version().major < 0 or (vim.version().major == 0 and vim.version().minor < 10) then
  vim.notify("Neovim 0.10+ required", vim.log.levels.ERROR)
  return
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("init.keymaps")
require("init.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.core" },
    { import = "plugins.lsp" },
    { import = "plugins.ui" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
