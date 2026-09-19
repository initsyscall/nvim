vim.g.netrw_banner = 0

local explorer_prev_buf = nil

vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "netrw" then
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

vim.api.nvim_create_autocmd("FileType", {

  pattern = "netrw",

  callback = function()
    local opts = { buffer = true, silent = true, nowait = true }
    vim.keymap.set("n", "h", "<Plug>NetrwBrowseUpDir", opts)
    vim.keymap.set("n", "l", "<Plug>NetrwLocalBrowseCheck", opts)
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

