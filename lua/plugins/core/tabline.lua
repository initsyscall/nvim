return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers",
      themable = false,
      numbers = "none",
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator = { icon = "▎", style = "icon" },
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 30,
      max_prefix_length = 15,
      truncate_names = true,
      tab_size = 0,
      diagnostics = false,
      show_buffer_icons = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = false,
      show_duplicate_prefix = true,
      persist_buffer_sort = true,
      move_wraps_at_ends = false,
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      sidebar_filetypes = { "neo-tree" },
      offsets = {
        { filetype = "neo-tree", text = "", separator = true },
      },
      sort_by = "insert_at_end",
    },
    highlights = {
      background = { bg = "NONE" },
      fill = { bg = "NONE" },
      buffer_selected = { bg = "NONE", bold = true },
      separator = { bg = "NONE" },
      separator_selected = { bg = "NONE" },
      modified = { bg = "NONE" },
      modified_selected = { bg = "NONE" },
      duplicate = { bg = "NONE", fg = { attribute = "fg", highlight = "Comment" } },
      duplicate_selected = { bg = "NONE", fg = { attribute = "fg", highlight = "Comment" } },
      offset_separator = { bg = "NONE" },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
      callback = function()
        vim.o.showtabline = vim.api.nvim_buf_get_name(0) == "" and 0 or 2
      end,
    })
  end,
}