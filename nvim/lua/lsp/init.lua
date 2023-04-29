local M = {}

local disabled_servers = {
  'tsserver',
}

function M.config()
  local lspconfig = require('lspconfig')
  local mason = require('mason')
  local lsp_installer = require('mason-lspconfig')
  local global_border = require('core.globals').border

  mason.setup({ ui = { border = global_border } })
  lsp_installer.setup({})

  -- Override open_floating_preview function to enable borders globally
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or global_border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = require('lsp.on_attach')
  local configs = require('lsp.configs')
  require('lsp.null_ls').setup(on_attach)

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_lsp = require('cmp_nvim_lsp')
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

  local options = {
    on_attach = on_attach,
    capabilities = cmp_lsp.default_capabilities(capabilities),
    flags = {
      debounce_text_changes = 250,
    },
  }

  lsp_installer.setup_handlers({
    function(server_name)
      if not vim.tbl_contains(disabled_servers, server_name) then
        local server_options =
          vim.tbl_extend('force', options, configs[server_name] or {})
        lspconfig[server_name].setup(server_options)
      end
    end,
  })

  require('typescript').setup({
    server = options,
  })

  local signs = require('core.globals').diagnostic_signs

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
  end

  vim.diagnostic.config({
    underline = true,
    virtual_text = {
      source = false,
      severity = {
        min = vim.diagnostic.severity.WARN,
      },
    },
    signs = false,
    float = {
      source = 'always',
      border = global_border,
    },
    severity_sort = true,
    update_in_insert = false,
  })

  vim.lsp.handlers['textDocument/definition'] = function(_, result)
    if not result or vim.tbl_isempty(result) then
      print('[LSP] Could not find definition')
      return
    end

    if vim.tbl_islist(result) then
      vim.lsp.util.jump_to_location(result[1], 'utf-8')
    else
      vim.lsp.util.jump_to_location(result, 'utf-8')
    end
  end
end

return M
