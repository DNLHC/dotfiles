return function(p)
  local bg = p.bg3u
  local fg = p.fg
  local inactive_fg = p.fg3d

  local theme = {
    a = { bg = p.bg5u, fg = fg },
    b = { bg = bg, fg = fg },
    c = { bg = bg, fg = fg },
    x = { bg = bg, fg = fg },
    y = { bg = bg, fg = fg },
    z = { bg = p.bg5u, fg = fg },
  }

  local inactive_theme = {
    a = { bg = p.bg4u, fg = inactive_fg },
    b = { bg = p.bg3u, fg = inactive_fg },
    c = { bg = p.bg3u, fg = inactive_fg },
    x = { bg = p.bg3u, fg = inactive_fg },
    y = { bg = p.bg3u, fg = inactive_fg },
    z = { bg = p.bg4u, fg = inactive_fg },
  }

  return {
    normal = theme,
    insert = theme,
    visual = theme,
    replace = theme,
    command = theme,
    inactive = inactive_theme,
  }
end
