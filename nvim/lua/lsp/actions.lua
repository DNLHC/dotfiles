local M = {}

function M.goto_definition()
  local util = vim.lsp.util
  local log = require('vim.lsp.log')
  local reuse_win = false

  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end
    local client = vim.lsp.get_client_by_id(ctx.client_id)

    local split_win = vim.fn.winnr('l')
    local has_split = vim.fn.winnr() ~= split_win

    if has_split then
      vim.api.nvim_set_current_win(vim.fn.win_getid(split_win))
    else
      vim.cmd('vsplit')
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1], client.offset_encoding, reuse_win)
    else
      util.jump_to_location(result, client.offset_encoding, reuse_win)
    end
  end

  return handler
end

return M
