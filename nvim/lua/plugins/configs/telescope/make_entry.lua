local M = {}
local entry_display = require('telescope.pickers.entry_display')

local filter = vim.tbl_filter
local map = vim.tbl_map

function M.make_buffers_entry(opts)
  opts = opts or {}

  local make_display = function(entry)
    local bufnrs = filter(function(b)
      return 1 == vim.fn.buflisted(b)
    end, vim.api.nvim_list_bufs())

    local max_bufnr = math.max(unpack(bufnrs))
    local bufnr_width = #tostring(max_bufnr)

    local max_bufname = math.max(unpack(map(function(bufnr)
      local bufn = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:t')
      return vim.fn.strdisplaywidth(bufn)
    end, bufnrs)))

    local displayer = entry_display.create({
      separator = ' ',
      items = {
        { width = bufnr_width },
        { width = 4 },
        { width = max_bufname },
        { remaining = true },
      },
    })

    return displayer({
      { entry.bufnr, 'TelescopeResultsNumber' },
      { entry.indicator, 'TelescopeResultsComment' },
      entry.file_name,
      { entry.dir_name, 'TelescopeResultsFilePath' },
    })
  end

  return function(entry)
    local bufname = entry.info.name ~= '' and entry.info.name or '[No Name]'
    local hidden = entry.info.hidden == 1 and 'h' or 'a'
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, 'readonly')
        and '='
      or ' '
    local changed = entry.info.changed == 1 and '+' or ' '
    local indicator = entry.flag .. hidden .. readonly .. changed

    local file_name = vim.fn.fnamemodify(bufname, ':p:t')
    local dir_name = vim.fn.fnamemodify(bufname, ':~:.:h')

    if dir_name == '.' then
      dir_name = './'
    end

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. ' : ' .. file_name,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end

return M
