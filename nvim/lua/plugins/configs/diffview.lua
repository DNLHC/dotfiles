local actions = require('diffview.actions')
local globals = require('core.globals')

return {
  use_icons = false,
  enhanced_diff_hl = true,
  signs = {
    fold_closed = globals.arrow_closed,
    fold_open = globals.arrow_open,
  },
  file_panel = {
    listing_style = 'list',
  },
  hooks = {
    diff_buf_win_enter = function()
      vim.wo.wrap = false
      vim.wo.list = false
      vim.wo.number = false
      vim.wo.statuscolumn = ''
      vim.wo.signcolumn = 'no'
    end,
    view_opened = function(view)
      view.winopts.diff2.a.winhl = {
        'DiffChange:DiffDelete',
        'DiffText:DiffviewDiffDeleteHighlight',
        'DiffAdd:DiffDelete',
        'DiffDelete:DiffviewDiffDelete',
      }
      view.winopts.diff2.b.winhl = {
        'DiffChange:DiffAdd',
        'DiffText:DiffviewDiffAddHighlight',
        'DiffDelete:DiffviewDiffDelete',
      }
    end,
  },

  keymaps = {
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      ['<leader>e'] = actions.focus_files, -- Bring focus to the files panel
      ['<leader>b'] = actions.toggle_files, -- Toggle the files panel.
      ['Q'] = '<CMD>DiffviewClose<CR>',
    },
    file_panel = {
      ['-'] = false,
      ['s'] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
      ['<c-u>'] = actions.scroll_view(-0.25), -- Scroll the view up
      ['<c-d>'] = actions.scroll_view(0.25), -- Scroll the view down
      ['<leader>e'] = actions.focus_files,
      ['<leader>b'] = actions.toggle_files,
      ['q'] = actions.close,
      ['Q'] = '<CMD>DiffviewClose<CR>',
    },
    file_history_panel = {
      ['<c-u>'] = actions.scroll_view(-0.25),
      ['<c-d>'] = actions.scroll_view(0.25),
      ['<leader>e'] = actions.focus_files,
      ['<leader>b'] = actions.toggle_files,
      ['q'] = actions.close,
      ['Q'] = '<CMD>DiffviewClose<CR>',
    },
    option_panel = {
      ['<tab>'] = actions.select_entry,
      ['q'] = actions.close,
      ['Q'] = '<CMD>DiffviewClose<CR>',
    },
  },
}
