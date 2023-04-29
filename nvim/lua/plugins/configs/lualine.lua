local formatter = require('lsp.formatter')

-- vim.api.nvim_create_autocmd('RecordingEnter', {
--   callback = function()
--     require('lualine').refresh({
--       place = { 'statusline' },
--     })
--   end,
-- })

-- vim.api.nvim_create_autocmd('RecordingLeave', {
--   callback = function()
--     local timer = vim.loop.new_timer()
--     timer:start(
--       50,
--       0,
--       vim.schedule_wrap(function()
--         require('lualine').refresh({
--           place = { 'statusline' },
--         })
--       end)
--     )
--   end,
-- })

-- local function show_macro_recording()
--   local recording_register = vim.fn.reg_recording()
--   if recording_register == '' then
--     return ''
--   else
--     return 'recording @' .. recording_register
--   end
-- end
--
-- local function search_results()
--   if vim.v.hlsearch == 0 then
--     return ''
--   end
--
--   local last_search = vim.fn.getreg('/')
--   local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
--   local denominator = math.min(res.total, res.maxcount)
--
--   if res.total > 0 and last_search and last_search ~= '' then
--     return string.format('?%s [%d/%d]', last_search, res.current, denominator)
--   end
--
--   return ''
-- end

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
  return string.format('Ln %d, Col %d', line, col)
end

return {
  extensions = { 'quickfix', 'nvim-tree', 'toggleterm', 'man' },
  options = {
    global_status = true,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      statusline = {
        'toggleterm',
        'Trouble',
      },
    },
    theme = require('colorscheme.alabaster.lualine')(palette()),
    refresh = { statusline = 500 },
  },
  sections = {
    lualine_a = {
      { 'branch', icon = '' },
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
        return (formatter.enable_autoformat and 'F+') or 'F-'
      end,
      'encoding',
      'filetype',
    },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'filetype' },
  },
}
