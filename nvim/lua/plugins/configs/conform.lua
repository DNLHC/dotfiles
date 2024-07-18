local M = {}

M.setup = function()
  local conform = require('conform')
  local prettier_formatter = { { 'prettierd', 'prettier' } }

  conform.setup({
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      local bufname = vim.api.nvim_buf_get_name(bufnr)

      if bufname:match('/node_modules/') then
        return
      end

      return { timeout_ms = 1500, lsp_fallback = true }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
      css = prettier_formatter,
      graphql = prettier_formatter,
      handlebars = prettier_formatter,
      html = prettier_formatter,
      javascript = prettier_formatter,
      javascriptreact = prettier_formatter,
      json = prettier_formatter,
      jsonc = prettier_formatter,
      less = prettier_formatter,
      markdown = prettier_formatter,
      ['markdown.mdx'] = prettier_formatter,
      scss = prettier_formatter,
      typescript = prettier_formatter,
      typescriptreact = prettier_formatter,
      vue = prettier_formatter,
      yaml = prettier_formatter,
      pug = prettier_formatter,
      webc = prettier_formatter,
      astro = prettier_formatter,
    },

    formatters = {
      prettierd = {
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.prettierrc'),
        },
      },
    },
  })

  vim.api.nvim_create_user_command('Format', function(args)
    local range = nil

    if args.count ~= -1 then
      local end_line =
        vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, end_line:len() },
      }
    end

    require('conform').format({
      async = true,
      lsp_fallback = true,
      range = range,
    })
  end, { range = true })

  vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
    vim.cmd('redrawstatus!')
  end, {
    desc = 'Disable autoformat-on-save',
    bang = true,
  })

  vim.api.nvim_create_user_command('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    vim.cmd('redrawstatus!')
  end, {
    desc = 'Re-enable autoformat-on-save',
  })
end

return M
