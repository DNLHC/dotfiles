return function(p)
  local bg = p.bg2u
  local fg_active = p.fg2d

  local theme = {
    a = { bg = p.bg4u, fg = p.fg },
    b = { bg = bg, fg = fg_active },
    c = { bg = bg, fg = fg_active },
    x = { bg = bg, fg = p.fg },
    y = { bg = bg, fg = fg_active },
    z = { bg = p.bg4u, fg = p.fg },
  }

  return {
    normal = theme,
    insert = theme,
    visual = theme,
    replace = theme,
    command = theme,
    inactive = theme,
  }
end
