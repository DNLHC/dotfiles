local globals = require('core.globals')
local actions = require('glance').actions

return {
  height = 20,
  -- detached = false,
  preview_win_opts = {
    number = false,
  },
  mappings = {
    list = {
      ['h'] = actions.close_fold,
      ['l'] = actions.open_fold,
      ['o'] = actions.toggle_fold,
    },
  },
  hooks = {
    before_open = function(results, open, jump)
      if #results == 1 then
        jump(results[1])
      else
        open(results)
      end
    end,
  },
  folds = {
    fold_closed = globals.arrow_closed,
    fold_open = globals.arrow_open,
  },
}
