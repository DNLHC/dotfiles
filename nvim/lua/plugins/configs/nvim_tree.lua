local globals = require('core.globals')

local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts)
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts)
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts)
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts)
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts)
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts)
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts)
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts)
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts)
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts)
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts)
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts)
  vim.keymap.set('n', '.', api.node.run.cmd, opts)
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts)
  vim.keymap.set('n', 'a', api.fs.create, opts)
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts)
  vim.keymap.set('n', 'bd', function()
    local nodes = api.marks.list()
    for index, node in ipairs(nodes) do
      api.fs.remove(node)
      api.marks.toggle(node)
    end
    api.marks.clear()
  end, opts)
  vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts)
  vim.keymap.set('n', 'c', api.fs.copy.node, opts)
  vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts)
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts)
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts)
  vim.keymap.set('n', 'd', api.fs.remove, opts)
  vim.keymap.set('n', 'D', api.fs.trash, opts)
  vim.keymap.set('n', 'E', api.tree.expand_all, opts)
  vim.keymap.set('n', 'e', api.fs.rename_basename, opts)
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts)
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts)
  vim.keymap.set('n', 'F', api.live_filter.clear, opts)
  vim.keymap.set('n', 'f', api.live_filter.start, opts)
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts)
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts)
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts)
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts)
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts)
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts)
  vim.keymap.set('n', 'm', api.marks.toggle, opts)
  vim.keymap.set('n', 'o', api.node.open.edit, opts)
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts)
  vim.keymap.set('n', 'p', api.fs.paste, opts)
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts)
  vim.keymap.set('n', 'q', api.tree.close, opts)
  vim.keymap.set('n', 'r', api.fs.rename, opts)
  vim.keymap.set('n', 'R', api.tree.reload, opts)
  vim.keymap.set('n', 's', api.node.run.system, opts)
  vim.keymap.set('n', 'S', api.tree.search_node, opts)
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts)
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts)
  vim.keymap.set('n', 'x', api.fs.cut, opts)
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts)
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts)
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts)
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts)
  -- END_DEFAULT_ON_ATTACH

  -- Mappings removed via:
  --   remove_keymaps
  --   OR
  --   view.mappings.list..action = ""
  --
  -- The dummy set before del is done for safety, in case a default mapping does not exist.
  --
  -- You might tidy things by removing these along with their default mapping.
  vim.keymap.set('n', '.', '', { buffer = bufnr })
  vim.keymap.del('n', '.', { buffer = bufnr })
  vim.keymap.set('n', '<C-k>', '', { buffer = bufnr })
  vim.keymap.del('n', '<C-k>', { buffer = bufnr })
  vim.keymap.set('n', '<C-.>', '', { buffer = bufnr })
  vim.keymap.del('n', '<C-.>', { buffer = bufnr })

  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set('n', 'v', api.node.open.vertical, opts)
  vim.keymap.set('n', 'i', api.node.open.preview, opts)
  vim.keymap.set('n', 's', api.node.open.horizontal, opts)
  vim.keymap.set('n', 'gh', api.node.show_info_popup, opts)
  vim.keymap.set('n', 'H', api.tree.collapse_all, opts)
end
return {
  hijack_netrw = true,
  update_focused_file = { enable = true },
  update_cwd = false,
  filters = {
    custom = { 'node_modules', 'vendor' },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = globals.diagnostic_signs.Hint,
      info = globals.diagnostic_signs.Info,
      warning = globals.diagnostic_signs.Warn,
      error = globals.diagnostic_signs.Error,
    },
  },
  renderer = {
    add_trailing = true,
    icons = {
      git_placement = 'after',
      padding = '',
      webdev_colors = false,
      show = {
        file = false,
        folder = true,
        folder_arrow = true,
      },
      glyphs = {
        default = '',
        bookmark = '+',
        folder = {
          arrow_closed = globals.arrow_closed,
          arrow_open = globals.arrow_open,
          default = '',
          open = '',
          empty = '',
          symlink = '',
          symlink_open = '',
          empty_open = '',
        },
        git = {
          unstaged = 'M',
          staged = 'M',
          unmerged = 'U',
          renamed = 'R',
          untracked = '?',
          deleted = 'D',
          ignored = '!',
        },
      },
    },
  },
  on_attach = on_attach,
  view = {
    width = 35,
    side = 'left',
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = true,
      },
    },
    change_dir = {
      restrict_above_cwd = true,
    },
  },
}
