local util = {}

local function byte(value, offset)
  return bit.band(bit.rshift(value, offset), 0xFF)
end

local function rgb(color)
  color = vim.api.nvim_get_color_by_name(color)

  if color == -1 then
    color = 000
  end

  return { byte(color, 16), byte(color, 8), byte(color, 0) }
end

local function parse_color(color)
  if color == nil then
    return print('invalid color')
  end

  color = color:lower()

  if not color:find('#') and color ~= 'none' then
    color = require('colorscheme.alabaster.palette')()[color]
      or vim.api.nvim_get_color_by_name(color)
  end

  return color
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 (background) and 1 (foreground)
util.blend = function(fg, bg, alpha)
  fg = rgb(parse_color(fg))
  bg = rgb(parse_color(bg))

  local function blend_channel(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format(
    '#%02X%02X%02X',
    blend_channel(1),
    blend_channel(2),
    blend_channel(3)
  )
end

local function starts_with(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

---@param group string
---@param color table<string, string>
util.highlight = function(group, color)
  local group_name = group
  if starts_with(group, 'ts_') then
    group_name = '@' .. string.sub(group, 4)
  end
  if color.link then
    vim.api.nvim_set_hl(0, group_name, color)
  else
    color.fg = color.fg and parse_color(color.fg) or 'NONE'
    color.bg = color.bg and parse_color(color.bg) or 'NONE'
    color.sp = color.sp and parse_color(color.sp) or ''
    color.ctermfg = color.ctermfg and parse_color(color.ctermfg) or 'NONE'
    color.ctermbg = color.ctermbg and parse_color(color.ctermbg) or 'NONE'
    vim.api.nvim_set_hl(0, group_name, color)
  end
end

return util
