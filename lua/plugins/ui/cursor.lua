return {
  {
    'sphamba/smear-cursor.nvim',
    event = 'CursorMoved',
    opts = {
      stiffness = 0.7,
      trail_length = 10,
      smear_between_buffers = true,
    },
  },
}
