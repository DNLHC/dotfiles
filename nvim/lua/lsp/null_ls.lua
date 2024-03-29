local M = {}

function M.setup(on_attach)
  local present, null_ls = pcall(require, 'null-ls')
  if not present then
    return
  end

  local typescript_code_actions =
    require('typescript.extensions.null-ls.code-actions')

  local builtins = null_ls.builtins
  local formatting = builtins.formatting
  local diagnostics = builtins.diagnostics
  local code_actions = builtins.code_actions

  null_ls.setup({
    sources = {
      formatting.stylua,
      formatting.prettierd.with({
        extra_filetypes = { 'pug', 'webc', 'astro' },
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
            '~/.config/nvim/utils/.prettierrc'
          ),
        },
      }),
      code_actions.eslint_d,
      typescript_code_actions,
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
