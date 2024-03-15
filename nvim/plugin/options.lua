local opt = vim.opt
opt.smartcase = true
opt.ignorecase = true
vim.g.editorconfig = false

if not vim.g.vscode then
  vim.g.cursorhold_updatetime = 250
  opt.list = true
  opt.listchars = {
    tab = '│ ',
    leadmultispace = '│ ',
    multispace = '│ ',
  }
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
  opt.laststatus = 3
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
    'linematch:100',
  })
  opt.wildignore:append({
    '.git',
    '**/node_modules/*',
    '**/vendor/*',
    '.hg',
    'dist',
  })
  opt.fillchars = {
    diff = '╱',
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
