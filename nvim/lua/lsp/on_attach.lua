local actions = require('lsp.actions')

return function(client, bufnr)
  if vim.b.large_buf then
    return
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { buffer = bufnr }
  vim.keymap.set('n', '<C-x>', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
  -- Open definition in a split window
  vim.keymap.set('n', '<C-w>gd', function()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(
      0,
      'textDocument/definition',
      params,
      actions.goto_definition()
    )
  end, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gl', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gm', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>', bufopts)
  vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>', bufopts)
  vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>', bufopts)
  vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>', bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set(
    'n',
    '<leader>wr',
    vim.lsp.buf.remove_workspace_folder,
    bufopts
  )
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  -- Symbols
  vim.keymap.set(
    'n',
    '<leader>sw',
    '<CMD>Telescope lsp_workspace_symbols<CR>',
    bufopts
  )
  vim.keymap.set(
    'n',
    '<leader>sb',
    '<CMD>Telescope lsp_document_symbols<CR>',
    bufopts
  )
  vim.keymap.set('n', 'ge', vim.lsp.buf.rename, bufopts)

  -- Highlight symbol
  -- if client.supports_method('textDocument/documentHighlight') then
  --   vim.api.nvim_create_augroup('lsp_document_highlight', {
  --     clear = false,
  --   })
  --   vim.api.nvim_clear_autocmds({
  --     buffer = bufnr,
  --     group = 'lsp_document_highlight',
  --   })
  --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  --     callback = vim.lsp.buf.document_highlight,
  --     buffer = bufnr,
  --     group = 'lsp_document_highlight',
  --   })
  --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  --     callback = vim.lsp.buf.clear_references,
  --     buffer = bufnr,
  --     group = 'lsp_document_highlight',
  --   })
  -- end
end
