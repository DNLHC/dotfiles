local M = {}

M.dark_palette = {
  green = '#95cb82',
  fg = '#cecece',
  blue = '#71ade7',
  purple = '#cc8bc9',
  yellow = '#dfdf8e',

  bg2d = '#0A0A0A',
  bg1d = '#111212',
  bg = '#19191A',
  bg1u = '#202021',
  bg2u = '#282829',
  bg3u = '#2E2F31',
  bg4u = '#37373A',
  bg5u = '#3f3f41',
  bg6u = '#47474A',

  fg1u = '#d1d1d1',
  fg1d = '#bababa',
  fg2d = '#a7a7a7',
  fg3d = '#949494',
  fg4d = '#6f6f6f',
  -- green = '#00cc66',
  red = '#f14c4c',
  orange = '#cca700',
  -- blue = '#163764',
  punctuation = '#708b8d',
  none = 'NONE',
}

M.light_palette = {
  green = '#448c27',
  fg = '#000000',
  blue = '#0550ae',
  purple = '#7a3e9d',
  red = '#aa3731',
  cyan = '#004d55',

  fg1d = '#1b1b1b',
  fg2d = '#303030',
  fg3d = '#464646',
  fg4d = '#5d5d5d',
  fg5d = '#767676',

  selection = '#c2ddfc',
  search = '#f0ebb4',
  cur_search = '#f0d1b4',
  yank = '#f0dca8',

  bg2d = '#ffffff',
  bg1d = '#ffffff',
  bg = '#fafafa',
  bg1u = '#f1f1f1',
  bg2u = '#e8e8e8',
  bg3u = '#e0e0e0',
  bg4u = '#d7d7d7',
  bg5u = '#cfcfcf',
  bg6u = '#c6c6c6',

  orange = '#C48B00',
  punctuation = '#555555',
  diff = {
    add = '#89d5a0',
    remove = '#f99b9b',
    change = '#d5c489',
  },
  none = 'NONE',
}

return function()
  if vim.opt.background._value == 'dark' then
    return M.dark_palette
  end

  return M.light_palette
end
