return function(p)
  local bg = p.bg2u
  local fg = p.fg

  local theme = {
    a = { bg = p.bg4u, fg = fg },
    b = { bg = bg, fg = fg },
    c = { bg = bg, fg = fg },
    x = { bg = bg, fg = fg },
    y = { bg = bg, fg = fg },
    z = { bg = p.bg4u, fg = fg },
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
