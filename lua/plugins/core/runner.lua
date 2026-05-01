return {
  -- Overseer: Task runner for projects (make, npm, cargo, etc.)
  {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {
      templates = { 'builtin' },
      task_list = {
        direction = 'bottom',
        min_height = 10,
        max_height = 0.4,
        border = 'rounded',
        keymaps = {
          ['<CR>'] = 'keymap.run_action',
          ['dd'] = { 'keymap.run_action', opts = { action = 'dispose' } },
          ['p'] = 'keymap.toggle_preview',
          ['{'] = 'keymap.prev_task',
          ['}'] = 'keymap.next_task',
          ['q'] = { '<CMD>close<CR>', desc = 'Close' },
        },
      },
      task_win = { border = 'rounded' },
    },
    config = function(_, opts)
      require('overseer').setup(opts)
    end,
    keys = {
      { '<leader>r', desc = 'Runner' },
      { '<leader>rr', function() vim.cmd('OverseerRun') end, desc = 'Run Task' },
      { '<leader>rt', function() vim.cmd('OverseerToggle') end, desc = 'Toggle Task List' },
      { '<leader>rd', function() require('overseer').restart() end, desc = 'Restart Task' },
      { '<leader>rs', function() require('overseer').stop() end, desc = 'Stop Task' },
    },
  },

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
