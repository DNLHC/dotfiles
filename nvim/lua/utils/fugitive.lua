local M = {}

local function is_fugitive(win)
  local buf = vim.api.nvim_win_get_buf(win)
  local bufname = vim.api.nvim_buf_get_name(buf)
  return bufname:match('^fugitive://')
end

M.close_other_windows = function()
  local wins = vim.fn.getwininfo()
  local main_win = 0

  for _, win in ipairs(wins) do
    if not (win.quickfix == 1 or win.loclist == 1) then
      local is_fugitive_win = is_fugitive(win.winid)
      local is_diff_win = win.variables.fugitive_diff_restore

      if is_fugitive_win and not is_diff_win then
        main_win = win.winid
      end

      if is_diff_win then
        vim.api.nvim_win_close(win.winid, false)
      end
    end
  end

  vim.api.nvim_set_current_win(main_win)
end

return M
