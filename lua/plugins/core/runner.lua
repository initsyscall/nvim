return {
  -- Runner.nvim: Run current file with one command
  {
    'samonide/runner.nvim',
    event = 'VeryLazy',
    config = function()
      require('runner').setup({
        filetype = {
          lua = {
            type = 'interpreted',
            command = 'lua',
          },
          python = {
            type = 'interpreted',
            command = 'python3',
          },
          javascript = {
            type = 'interpreted',
            command = 'node',
          },
          typescript = {
            type = 'compiled',
            compile = 'tsc',
            command = 'node',
          },
        },
      })
    end,
    keys = {
      { '<leader>rc', '<cmd>RunCode<cr>', desc = 'Run Code' },
      { '<leader>rC', '<cmd>RunFloat<cr>', desc = 'Run Float' },
      { '<leader>rw', '<cmd>RunWatch<cr>', desc = 'Run Watch' },
      { '<leader>rb', '<cmd>RunBuild<cr>', desc = 'Build Only' },
      { '<leader>rl', '<cmd>RunLast<cr>', desc = 'Run Last' },
    },
  },
}