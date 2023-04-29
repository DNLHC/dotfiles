local M = {}

local steps = 3

local has_win = function(dir)
  return vim.fn.winnr() ~= vim.fn.winnr(dir)
end

local is_next_win_last = function()
  if has_win('j') and has_win('k') then
    local winnr = vim.fn.winnr('j')
    local next_winnr = vim.api.nvim_win_call(vim.fn.win_getid(winnr), function()
      return vim.fn.winnr('k')
    end)
    return vim.fn.winnr() ~= next_winnr
  end
  return false
end

function M.down()
  if is_next_win_last() then
    vim.cmd(string.format('%sresize -%s', vim.fn.winnr('j'), steps))
    return
  end

  if has_win('j') then
    vim.cmd(string.format('resize +%s', steps))
  else
    vim.cmd(string.format('%sresize +%s', vim.fn.winnr('k'), steps))
  end
end

function M.up()
  if is_next_win_last() then
    vim.cmd(string.format('%sresize +%s', vim.fn.winnr('j'), steps))
    return
  end

  if has_win('j') then
    vim.cmd(string.format('resize -%s', steps))
  else
    vim.cmd(string.format('resize +%s', steps))
  end
end

function M.left()
  if has_win('l') then
    vim.cmd(string.format('vertical resize -%s', steps))
  else
    vim.cmd(string.format('vertical %sresize -%s', vim.fn.winnr('h'), steps))
  end
end

function M.right()
  if has_win('l') then
    vim.cmd(string.format('vertical resize +%s', steps))
  else
    vim.cmd(string.format('vertical resize -%s', steps))
  end
end

return M
