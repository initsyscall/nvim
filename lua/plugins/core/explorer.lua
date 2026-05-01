return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      close_if_last_window = true,
      hijack_netrw_behavior = "open_default",
       commands = {
         change_context = function(state)
           local node = state.tree:get_node()
           local path = node.type == "file" and node:get_parent_id() or node.path
           vim.api.nvim_set_current_dir(path)
           require("neo-tree.sources.filesystem.commands").set_root(state)
           require("util").notify("CWD set to:\n" .. path, "Neotree")
         end,
       },

      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "navigate_up",
          ["L"] = "change_context",
        },
      },
      default_component_configs = {
        indent = { with_expanders = true, expander_collapsed = "", expander_expanded = "" },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
        modified = { symbol = "●" },
        git_status = {
          symbols = {
            added = "✚",
            modified = "󰓎",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
    },
  },

  {
    "echasnovski/mini.files",
    version = false,
    keys = {
      {
        "<leader>m",
        function()
          local mf = require("mini.files")
          local buf_name = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
          mf.open(path)
          mf.reveal_cwd()
        end,
        desc = "Explorer Mini (Current File)",
      },
    },
    opts = {
      options = { use_as_default_explorer = false },
      windows = {
        max_number = math.huge,
        preview = true,
        width_focus = 30,
        width_nofocus = 15,
        width_preview = 40,
      },
      mappings = {
        close = "q",
        go_in = "l",
        go_in_plus = "L",
        go_out = "h",
        go_out_plus = "H",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          local fs_entry = require("mini.files").get_fs_entry()
          local is_dir = fs_entry ~= nil and fs_entry.fs_type == "directory"
          if not is_dir then
            local path = fs_entry.path
            require("mini.files").close()
            vim.cmd(direction .. " " .. vim.fn.fnameescape(path))
          end
        end
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
      end

       local set_cwd = function()
         local entry = require("mini.files").get_fs_entry()
         if not entry then return end
         local path = entry.path
         if entry.fs_type == "file" then
           path = vim.fs.dirname(path)
         end
         vim.api.nvim_set_current_dir(path)
         require("util").notify("CWD set to:\n" .. path, "Mini.files")
       end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          map_split(buf_id, "<C-s>", "split")
          map_split(buf_id, "<C-v>", "vsplit")
          vim.keymap.set("n", "<ESC>", function() require("mini.files").close() end, { buffer = buf_id })
          vim.keymap.set("n", "'", set_cwd, { buffer = buf_id, desc = "Set CWD" })
        end,
      })
    end,
  },
}
