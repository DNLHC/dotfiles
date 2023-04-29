return {
  size = function(term)
    if term.direction == 'horizontal' then
      return 18
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.45
    end
  end,
  shade_terminals = false,
  open_mapping = [[<c-\>]],
  insert_mappings = false,
  float_opts = {
    border = 'curved',
  },
}
