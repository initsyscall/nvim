return {
  "windwp/nvim-spectre",
  event = "VeryLazy",
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").toggle()
      end,
      desc = "Search & Replace (Spectre)",
    },
  },
  opts = {},
}
