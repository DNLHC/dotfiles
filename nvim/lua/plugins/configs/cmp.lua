local present, cmp = pcall(require, 'cmp')
if not present then
  return
end

-- cmp.event:on('menu_opened', function()
--   vim.b.copilot_suggestion_hidden = true
-- end)
--
-- cmp.event:on('menu_closed', function()
--   vim.b.copilot_suggestion_hidden = false
-- end)
--
-- local copilot_suggestions = require('copilot.suggestion')

local WIDE_HEIGHT = 40

cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    completion = {
      col_offset = 0,
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      side_padding = 1,
    },
    documentation = {
      max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
      max_width = math.floor(
        (WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))
      ),
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
    },
  },
  formatting = {
    fields = { 'abbr', 'menu', 'kind' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-c>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Insert,
        })
      -- elseif copilot_suggestions.is_visible() then
      --   copilot_suggestions.accept()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function()
      cmp.complete()
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length = 2 },
    -- { name = 'copilot' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua', keyword_length = 3 },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  experimental = {
    ghost_text = { hl_group = 'GhostText' },
  },
})

cmp.setup.filetype('vim', {
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.confirm({ select = true })
        cmp.complete()
      else
        cmp.complete()
      end
    end, { 'i', 'c' }),
    ['<C-n>'] = cmp.config.disable,
    ['<C-p>'] = cmp.config.disable,
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline({
    ['<Tab>'] = cmp.mapping(
      cmp.mapping.confirm({ select = true }),
      { 'i', 'c' }
    ),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  }),
  sources = {
    { name = 'buffer' },
  },
})
