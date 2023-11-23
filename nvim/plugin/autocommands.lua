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
      local max_filesize = 100 * 1024 -- 100 KB
      local max_minified_filesize = 10 * 1024 -- 10 KB
      local lcount = vim.api.nvim_buf_line_count(buf)
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

      if
        ok
        and stats
        and (
          stats.size > max_filesize
          or (lcount < 30 and stats.size > max_minified_filesize)
        )
      then
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
  local function update_lead()
    local lcs = vim.opt_local.listchars:get()
    local tab = vim.fn.str2list(lcs.tab)
    local space = vim.fn.str2list(lcs.multispace or lcs.space)
    local lead = { tab[1] }
    for i = 1, vim.bo.tabstop - 1 do
      lead[#lead + 1] = space[i % #space + 1]
    end
    vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })
  end

  vim.api.nvim_create_autocmd(
    'OptionSet',
    { pattern = { 'listchars', 'tabstop', 'filetype' }, callback = update_lead }
  )
  vim.api.nvim_create_autocmd(
    'VimEnter',
    { callback = update_lead, once = true }
  )

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
