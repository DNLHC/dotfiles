return {
  func_map = {
    split = '<C-s>',
  },
  filter = {
    fzf = {
      action_for = { ['ctrl-s'] = 'split' },
    },
  },
  preview = {
    auto_preview = true,
    show_title = false,
    win_height = 18,
    should_preview_cb = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      return fsize < 50 * 1024 -- skip file size greater thank 50k
    end,
    border_chars = {
      '',
      '',
      '─',
      '',
      '',
      '',
      '',
      '',
      '█',
    },
  },
}
