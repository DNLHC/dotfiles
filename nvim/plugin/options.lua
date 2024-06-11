local opt = vim.opt
opt.smartcase = true
opt.ignorecase = true
vim.g.editorconfig = false
local fn = vim.fn

function _G.qftf(info)
  local items
  local ret = {}

  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end

  local limit = 36
  local fnameFmt1 = '%-' .. limit .. 's'
  local fnameFmt2 = '…%.' .. (limit - 1) .. 's'

  local validFmt = '%s│%4d:%-4d│%s %s'

  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)

        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end

        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end

      local lnum = e.lnum > 9999 and -1 or e.lnum
      local col = e.col > 9999 and -1 or e.col
      local qtype = e.type == '' and '' or e.type:sub(1, 1):upper()

      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end

    table.insert(ret, str)
  end

  return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

if not vim.g.vscode then
  vim.g.cursorhold_updatetime = 250
  opt.shiftwidth = 2
  opt.tabstop = 2
  opt.smartindent = true
  opt.expandtab = true
  opt.undofile = true
  opt.breakindent = true
  opt.encoding = 'utf-8'
  opt.ttyfast = true
  opt.termguicolors = true
  opt.hidden = true
  opt.grepformat = '%f:%l:%c:%m'
  opt.grepprg = 'rg --vimgrep'
  opt.clipboard:append('unnamedplus')
  opt.backup = false
  opt.swapfile = false
  opt.writebackup = false
  opt.splitbelow = true
  opt.splitright = true
  opt.cursorline = true
  opt.number = false
  opt.scrolloff = 1
  opt.mouse = 'nvi'
  opt.inccommand = 'split'
  opt.completeopt = { 'menu', 'menuone', 'noselect' }
  opt.pumheight = 12
  opt.signcolumn = 'yes:1'
  opt.backspace = 'indent,eol,start'
  opt.laststatus = 2
  opt.updatetime = 300
  opt.foldlevel = 10
  opt.foldnestmax = 3
  opt.foldcolumn = '0'
  opt.foldopen:append('jump')
  opt.foldmethod = 'expr'
  opt.foldexpr = 'nvim_treesitter#foldexpr()'
  opt.foldenable = false
  opt.showmode = false
  opt.cmdheight = 1
  opt.spelllang = 'en_us,ru'
  opt.spell = false
  opt.numberwidth = 3
  opt.diffopt:append({
    'filler',
    'context:5',
    'vertical',
    'linematch:60',
  })
  opt.wildignore:append({
    '**/.git',
    '**/.hg',
    '**/node_modules/*',
    '**/vendor/*',
    '**/dist/*',
    '**/.svn/*',
    '**/CVS',
    '**/.DS_Store',
    '**/Thumbs.db',
  })
  opt.fillchars = {
    diff = '╱',
  }
  opt.listchars = {
    tab = '│ ',
    leadmultispace = '│ ',
    multispace = '│ ',
  }

  opt.path = { '.', '**' }

  if vim.fn.has('nvim-0.9.0') == 1 then
    opt.statuscolumn = '%=%l%s'
    opt.splitkeep = 'screen'

    vim.filetype.add({
      extension = {
        pcss = 'scss',
        webc = 'html',
      },
      filename = {
        ['.eslintrc'] = 'json',
        ['.postcssrc'] = 'json',
        ['.parcelrc'] = 'json',
        ['.babelrc'] = 'json',
        ['.nanorc'] = 'json',
        ['.stylelintrc'] = 'json',
        ['.pug-lintrc'] = 'json',
        ['.posthtmlrc'] = 'json',
        ['.cssnanorc'] = 'json',
      },
    })
  end
end
