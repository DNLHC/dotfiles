local M = {}

function M.goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require('vim.lsp.log')
  local api = vim.api
  local reuse_win = false

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end
    local client = vim.lsp.get_client_by_id(ctx.client_id)

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1], client.offset_encoding, reuse_win)

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result, client.offset_encoding))
        api.nvim_command('copen')
        api.nvim_command('wincmd p')
      end
    else
      util.jump_to_location(result, client.offset_encoding, reuse_win)
    end
  end

  return handler
end

return M
