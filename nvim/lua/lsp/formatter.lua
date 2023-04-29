local M = {}
local nls_sources = require('null-ls.sources')

M.enable_autoformat = true

function M.format(client, bufnr)
  vim.lsp.buf.format({
    filter = function(_client)
      return _client.name == client.name
    end,
    timeout_ms = 2000,
    bufnr = bufnr,
  })
end

function M.toggle_autoformat()
  M.enable_autoformat = not M.enable_autoformat
  if M.enable_autoformat then
    print('[Formatting]: Enabled format on save')
  else
    print('[Formatting]: Disabled format on save')
  end
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

function M.setup(client, bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local enable = false

  if M.has_formatter(ft) then
    enable = client.name == 'null-ls'
  else
    enable = not (client.name == 'null-ls')
  end

  client.server_capabilities.documentFormattingProvider = enable
  client.server_capabilities.documentRangeFormattingProvider = enable

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if M.enable_autoformat then
          M.format(client, bufnr)
        end
      end,
    })
  end
end

function M.has_formatter(ft)
  local methods = require('null-ls').methods
  local method = methods.FORMATTING
  local available = nls_sources.get_available(ft, method)
  return #available > 0
end

return M
