local palette = require('colorscheme.alabaster.palette')

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function location()
  local line = vim.fn.line('.')
  local col = vim.fn.virtcol('.')
  return string.format('(%d, %d)', line, col)
end

return {
  extensions = { 'quickfix', 'nvim-tree', 'toggleterm', 'man' },
  options = {
    global_status = false,
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      statusline = {
        'toggleterm',
      },
    },
    theme = require('colorscheme.alabaster.lualine')(palette()),
    refresh = { statusline = 500 },
  },
  sections = {
    lualine_a = {
      { 'branch', icon = nil },
      { 'diff', source = diff_source, colored = false },
    },
    lualine_b = {
      {
        'diagnostics',
        colored = true,
        symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
        update_on_insert = false,
      },
    },
    lualine_c = { { 'filename', path = 1, shorting_target = 10 } },
    lualine_x = {},
    lualine_y = {
      function()
        if vim.b.disable_autoformat or vim.g.disable_autoformat then
          return 'F-'
        end
        return 'F+'
      end,
      'filetype',
    },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {
      { 'diff', source = diff_source, colored = false },
    },
    lualine_b = {
      {
        'diagnostics',
        colored = true,
        symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
        update_on_insert = false,
      },
    },
    lualine_c = { { 'filename', path = 1, shorting_target = 10 } },
    lualine_x = {},
    lualine_y = {
      'filetype',
    },
    lualine_z = { location },
  },
}
