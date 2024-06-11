local augroup = vim.api.nvim_create_augroup('CustomCommands', { clear = true })

-- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  pattern = '*',
  callback = function()
    local higroup = vim.fn.hlexists('HighlightedyankRegion') > 0
        and 'HighlightedyankRegion'
      or 'IncSearch'
    vim.highlight.on_yank({ timeout = 350, higroup = higroup })
  end,
})

if not vim.g.vscode then
  -- Disable some features on large or minified files
  vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
    pattern = '*',
    group = augroup,
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local max_filesize = 150 * 1024 -- 150 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

      if ok and stats and stats.size > max_filesize then
        vim.b.large_buf = true
        vim.cmd('syntax off')
        vim.diagnostic.disable(buf)
        vim.opt_local.foldmethod = 'manual'
        vim.opt_local.spell = false
        vim.opt_local.list = false
        vim.b.minihipatterns_disable = true
      end
    end,
  })
  -- Start terminal mode in insert mode and disable some options
  vim.api.nvim_create_autocmd('TermOpen', {
    group = augroup,
    pattern = '*',
    command = 'startinsert | setlocal winfixheight nospell norelativenumber nonumber signcolumn=no scrolloff=0 statuscolumn=',
  })

  -- Windows to close with "q"
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = {
      'help',
      'startuptime',
      'qf',
      'lspinfo',
      'tsplayground',
      'query',
      'checkhealth',
      'fugitive',
    },
    callback = function(opts)
      vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = opts.buf })
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = 'man',
    callback = function(opts)
      vim.keymap.set('n', 'q', '<CMD>quit<CR>', { buffer = opts.buf })
    end,
  })
end

vim.api.nvim_create_autocmd('VimResized', {
  group = augroup,
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})
