local M = {}

function M.setup(on_attach)
  local present, null_ls = pcall(require, 'null-ls')
  if not present then
    return
  end

  local builtins = null_ls.builtins
  local diagnostics = builtins.diagnostics
  local eslint_d_diagnostics = require('none-ls.diagnostics.eslint_d')
  local eslint_d_code_actions = require('none-ls.code_actions.eslint_d')

  null_ls.setup({
    sources = {
      eslint_d_code_actions,
      diagnostics.stylelint.with({
        extra_filetypes = { 'pcss', 'astro' },
      }),
      eslint_d_diagnostics.with({
        extra_args = { '--no-error-on-unmatched-pattern' }, -- don't remember why but it's there
      }),
    },
    debounce = 250,
    debug = false,
    on_attach = on_attach,
  })
end

return M
