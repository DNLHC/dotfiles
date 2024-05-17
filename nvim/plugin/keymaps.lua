local map = vim.keymap.set

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map({ 'n', 'x' }, '<C-j>', '4j', { noremap = false, silent = true })
map({ 'n', 'x' }, '<C-k>', '4k', { noremap = false, silent = true })
map({ 'n', 'x' }, '<C-e>', '2<C-e>')
map({ 'n', 'x' }, '<C-y>', '2<C-y>')

local function smart_delete()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  end
  return 'dd'
end

map('n', 'dd', smart_delete, { expr = true })
map({ 'n', 'x' }, '-', '$', { noremap = false })
map('x', 'v', '$h')

map({ 'n', 'x' }, 'gw', '*N')
map('i', '<C-CR>', '<C-o>o')
map('i', '<C-S-CR>', '<C-o>O')
map('i', '<C-l>', '<Del>')
map('i', '<C-k>', '<C-o>D')

-- Multi-cursor
map('n', 'cn', '*``cgn')
map('n', 'cN', '*``cgN')
local mc = [[y/\V<C-r>=escape(@", '/')<CR><CR>]]
map('x', 'cn', mc .. '``cgn')
map('x', 'cN', mc .. '``cgN')

map('x', 'p', '"_dP')
map('n', 's', '"_s')
map('n', 'x', '"_x')

map({ 'n', 'x' }, ';', ':', { noremap = false })

if not vim.g.vscode then
  map('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')
  map('c', 'w!!', 'w !sudo tee > /dev/null %')

  -- Exit from Terminal mode
  map('t', '<Esc>', '<C-\\><C-n>')
  map('t', 'jj', '<C-\\><C-n><C-w><C-p>')
  map('n', '<C-\\>', '<CMD>ToggleTerm<CR>')

  -- map('n', '<C-h>', '<CMD>bp<CR>')
  -- map('n', '<C-l>', '<CMD>bn<CR>')
  map('n', '<C-w><C-h>', '<C-w><S-h>')
  map('n', '<C-w><C-l>', '<C-w><S-l>')
  map('n', '<C-w><C-k>', '<C-w><S-k>')
  map('n', '<C-w><C-j>', '<C-w><S-j>')

  -- Git
  map('n', '<leader>gb', '<CMD>Gitsigns blame_line<CR>')
  map('n', '<leader>gg', '<CMD>Git<CR>')

  -- Diagnostics
  map('n', '<leader>e.', vim.diagnostic.open_float)
  map('n', '<leader>ee', vim.diagnostic.open_float)
  map('n', '[d', vim.diagnostic.goto_prev)
  map('n', ']d', vim.diagnostic.goto_next)

  local bufremove = require('mini.bufremove')

  map('n', '<leader>uu', '<CMD>UndotreeToggle<CR>')
  map('n', '<leader>uq', '<CMD>UndotreeHide<CR>')
  map('n', '<leader>uf', '<CMD>UndotreeFocus<CR>')

  -- Buffers
  map('n', '<leader>bq', function()
    return bufremove.delete()
  end)
  map('n', '<leader>bQ', function()
    return bufremove.delete(0, true)
  end)

  local function close_other_buffers(force)
    return function()
      local current_bufnr = vim.api.nvim_get_current_buf()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs() or {}) do
        if bufnr ~= current_bufnr and vim.fn.buflisted(bufnr) == 1 then
          bufremove.delete(bufnr, force or false)
        end
      end
    end
  end

  -- Clipboard
  require('osc52').setup({ silent = true, tmux_passthrough = true })

  local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
  end

  local function paste()
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
  end

  vim.g.clipboard = {
    name = 'osc52',
    copy = { ['+'] = copy, ['*'] = copy },
    paste = { ['+'] = paste, ['*'] = paste },
  }

  local function copy_relative_path()
    local path = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')
    copy({ path })
    vim.fn.setreg('"', path)
    print(path)
  end

  local function copy_relative_path_with_line_number()
    local value = ('%s:%s'):format(
      vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.'),
      vim.fn.line('.')
    )
    copy({ value })
    vim.fn.setreg('"', value)
    print(value)
  end
  -- Copy
  map('n', '<leader>xb', '<CMD>silent %y"<CR>') -- Yank relative path of the current buffer
  map('n', '<leader>xp', copy_relative_path) -- Yank relative path of the current buffer
  map('n', '<leader>xP', copy_relative_path_with_line_number) -- Yank relative path and current line number of the buffer

  map('n', '<leader>bb', '<CMD>Telescope buffers<CR>')
  map('n', '<leader>bo', close_other_buffers())
  map('n', '<leader>bO', close_other_buffers(true))
  map('n', '<leader>bl', '<CMD>ls<CR>:b<space>')
  map('n', '<leader>bf', '<CMD>Telescope current_buffer_fuzzy_find<CR>') -- Fuzzy search current buffer
  map('n', '<leader>b/', '<CMD>Telescope current_buffer_fuzzy_find<CR>') -- Fuzzy search current buffer

  -- Files
  map('n', '<leader>fd', '<CMD>call delete(expand("%")) | bd!<CR>')

  -- Quit
  map('n', '<leader>qq', '<CMD>qa<CR>')
  map('n', '<leader>qQ', '<CMD>qa!<CR>')
  map('n', '<leader>qw', '<CMD>qwa<CR>')

  local enable_diagnostic = true
  local function toggle_diagnostics()
    if enable_diagnostic then
      vim.diagnostic.disable()
    else
      vim.diagnostic.enable()
    end
    enable_diagnostic = not enable_diagnostic
  end

  -- Togle Options
  map('n', '<leader>on', '<CMD>set nu!<CR>') -- Toggle line numbers
  map('n', '<leader>og', '<CMD>Gitsigns toggle_signs<CR>') -- Toggle gitsigns
  map('n', '<leader>ow', '<CMD>set wrap!<CR>') -- Toggle wrap
  map('n', '<leader>or', '<CMD>set relativenumber!<CR>') -- Toggle relative number
  map('n', '<leader>oi', '<CMD>set list!<CR>') -- Toggle indent lines
  map('n', '<leader>os', '<CMD>set spell!<CR>')
  map('n', '<leader>ol', '<CMD>set cursorline!<CR>')
  map('n', '<leader>of', require('lsp.formatter').toggle_autoformat)
  map('n', '<leader>od', toggle_diagnostics)

  -- Terminal
  map('n', '<leader>tt', '<CMD>tabe term://bash<CR>')
  map('n', '<leader>tv', '<CMD>vs term://bash<CR>')
  map('n', '<leader>ts', '<CMD>sp term://bash<CR>')

  local resizer = require('utils.resizer')

  map('n', '<C-Left>', resizer.left)
  map('n', '<C-Right>', resizer.right)
  map('n', '<C-Up>', resizer.up)
  map('n', '<C-Down>', resizer.down)
end

if vim.g.vscode then
  local vscode_neovim = require('vscode-neovim')
  map({ 'n', 'x' }, 'gr', function()
    vscode_neovim.notify('editor.action.goToReferences')
  end)
  map({ 'n', 'x' }, 'gR', function()
    vscode_neovim.notify('references-view.findReferences')
  end)
  map({ 'n', 'x' }, 'gD', function()
    vscode_neovim.notify('editor.action.peekDefinition')
  end)
  map({ 'n', 'x' }, 'ge', function()
    vscode_neovim.notify('editor.action.rename')
  end)
end
