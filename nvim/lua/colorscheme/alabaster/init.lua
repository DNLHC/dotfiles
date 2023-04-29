local util = require('colorscheme.alabaster.util')
local M = {}

function M.colorscheme()
  local p = require('colorscheme.alabaster.palette')()

  local config = {
    bold_split = false,
    dark_variant = 'main',
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = true,
    disable_italics = true,

    groups = {
      background = p.bg,
      panel = p.bg1u,
      border = p.bg4u,
      status_line = p.bg2u,
      comment = p.red,
      link = p.fg,
      punctuation = p.punctuation,
      keyword = p.cyan,
      float_bg = p.bg2u,
      error = p.red,
      hint = p.fg1d,
      info = p.fg1d,
      warn = p.orange,

      git_add = p.green,
      git_change = p.orange,
      git_delete = p.red,
      git_dirty = p.orange,
      git_ignore = p.fg4d,
      git_merge = p.fg,
      git_rename = p.purple,
      git_stage = p.fg,
      git_text = p.fg,
    },
  }

  if vim.g.colors_name then
    vim.cmd('hi clear')
  end

  local theme = require('colorscheme.alabaster.theme').get(config, p)

  for group, color in pairs(theme) do
    util.highlight(group, color)
  end

  local treesitter_migrate = require('colorscheme.alabaster.treesitter')
  treesitter_migrate(p)
end

return M
