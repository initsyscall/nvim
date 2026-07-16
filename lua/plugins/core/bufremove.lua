return {
  "echasnovski/mini.bufremove",
  keys = {
    {
      "<leader>bd",
      function()
        require("mini.bufremove").delete(0, true)
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>bD",
      function()
        require("mini.bufremove").delete(0, true)
      end,
      desc = "Force delete buffer",
    },
    {
      "<leader>bw",
      function()
        require("mini.bufremove").wipeout(0)
      end,
      desc = "Wipeout buffer",
    },
  },
}
