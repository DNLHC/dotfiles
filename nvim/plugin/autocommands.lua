local augroup = vim.api.nvim_create_augroup('CustomCommands', { clear = true })

-- Start terminal mode in insert mode and disable some options
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  pattern = '*',
  command = 'startinsert | setlocal winfixheight nospell norelativenumber nonumber signcolumn=no scrolloff=0 statuscolumn=',
})

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

-- Show cursor line only in active window
local cl_group =
  vim.api.nvim_create_augroup('CursorLineControl', { clear = true })

local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = cl_group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end

-- set_cursorline('WinLeave', false)
-- set_cursorline('WinEnter', true)
-- set_cursorline('FileType', false, 'TelescopePrompt')

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
