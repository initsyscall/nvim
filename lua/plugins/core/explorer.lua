return {
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
          staged = "",
          conflict = "",
        },
      },
    },
  },
}