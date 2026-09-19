-- NETRW: all netrw management lives here (builtin explorer, no plugin)

vim.g.netrw_banner = 0 -- no help board at the top of the listing

-- Toggle the explorer rooted at the current working directory.
-- Pressing <leader>e again while in netrw returns to the previous buffer.
local explorer_prev_buf = nil
vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "netrw" then
    -- toggle off: back to the buffer we were editing before the explorer
    local explorer_buf = vim.fn.bufnr("%")
    if explorer_prev_buf ~= nil and vim.fn.bufexists(explorer_prev_buf) == 1 then
      vim.cmd("buffer " .. explorer_prev_buf)
    else
      vim.cmd("enew")
    end
    explorer_prev_buf = nil
    pcall(vim.api.nvim_buf_delete, explorer_buf, { force = true })
  else
    explorer_prev_buf = vim.fn.bufnr("%")
    vim.cmd("Ex " .. vim.fn.fnameescape(vim.fn.getcwd()))
  end
end, { desc = "Explorer (netrw)" })

-- h / l / L: neo-tree-style navigation inside netrw buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local opts = { buffer = true, silent = true, nowait = true }

    -- h: one step back (parent directory)
    vim.keymap.set("n", "h", "<Plug>NetrwBrowseUpDir", opts)

    -- l: one step forward (enter dir under cursor, open files like <CR>)
    vim.keymap.set("n", "l", "<Plug>NetrwLocalBrowseCheck", opts)

    -- L: cd into the dir under cursor and re-root the explorer there
    vim.keymap.set("n", "L", function()
      local word = vim.fn.expand("<cfile>")
      if word == "" then
        return
      end
      local base = vim.b.netrw_curdir or vim.fn.getcwd()
      local target
      if vim.fn.isdirectory(word) == 1 then
        target = word
      elseif vim.fn.isdirectory(base .. "/" .. word) == 1 then
        target = base .. "/" .. word
      end
      if not target then
        return
      end
      vim.api.nvim_set_current_dir(target)
      vim.cmd("Ex " .. vim.fn.fnameescape(vim.fn.getcwd()))
      require("util").notify("CWD set to:\n" .. target, "netrw")
    end, opts)
  end,
})