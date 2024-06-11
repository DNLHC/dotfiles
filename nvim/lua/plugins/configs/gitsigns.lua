return {
  signcolumn = false,
  attach_to_untracked = false,
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '▎',
    },
    change = {
      hl = 'GitSignsChange',
      text = '▎',
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '▁',
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '▔',
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '~',
    },
    untracked = {
      hl = 'GitSignsAdd',
      text = '+',
    },
  },
  preview_config = {
    border = require('core.globals').border,
  },
  on_attach = function(bufnr)
    local gs = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'x' }, '<leader>hs', '<CMD>Gitsigns stage_hunk<CR>')
    map({ 'n', 'x' }, '<leader>hr', '<CMD>Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function()
      gs.blame_line({ full = true })
    end)
    map('n', '<leader>hB', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function()
      gs.diffthis('~')
    end)
    -- map('n', '<leader>td', gs.toggle_deleted)
  end,
}
