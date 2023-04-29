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

  local cspell_extra_args = {
    '--config',
    '~/.config/nvim/utils/cspell.json',
    '-u',
    '--no-progress',
    '--no-summary',
  }

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
      -- code_actions.gitsigns,

      diagnostics.stylelint.with({
        extra_filetypes = { 'pcss', 'astro' },
      }),
      diagnostics.eslint_d.with({
        extra_args = { '--no-error-on-unmatched-pattern' },
      }),
      -- diagnostics.cspell.with({
      --   extra_args = cspell_extra_args,
      -- }),
      -- code_actions.cspell.with({
      --   extra_args = cspell_extra_args,
      -- }),
    },
    debounce = 250,
    debug = false,
    on_attach = on_attach,
  })
end

return M
