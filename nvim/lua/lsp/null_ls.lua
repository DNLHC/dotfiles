local M = {}

function M.setup(on_attach)
  local present, null_ls = pcall(require, 'null-ls')
  if not present then
    return
  end

  local builtins = null_ls.builtins
  local diagnostics = builtins.diagnostics
  local code_actions = builtins.code_actions

  null_ls.setup({
    sources = {
      code_actions.eslint_d,
      diagnostics.stylelint.with({
        extra_filetypes = { 'pcss', 'astro' },
      }),
      diagnostics.eslint_d.with({
        extra_args = { '--no-error-on-unmatched-pattern' }, -- don't remember why but it's there
      }),
    },
    debounce = 250,
    debug = false,
    on_attach = on_attach,
  })
end

return M
