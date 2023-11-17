local ignore_glob = {
  '**/.git/*',
  '**/.hg/*',
  '**/node_modules/*',
  '**/dist/*',
  '**/vendor/*',
  '**/.svn/*',
  '**/CVS',
  'package-lock.json',
  'yarn.lock',
  'composer.lock',
  '.pnp.js',
}

local function live_grep_in_path(path)
  local _path = path or vim.fn.input('Path: ', '', 'dir')
  require('telescope.builtin').live_grep({ search_dirs = { _path } })
end

local function find_files_in_path(path)
  local _path = path or vim.fn.input('Path: ', '', 'dir')
  require('telescope.builtin').find_files({ search_dirs = { _path } })
end

local function grep_string_in_path(path)
  local _path = path or vim.fn.input('Path: ', '', 'dir')
  require('telescope.builtin').grep_string({ search_dirs = { _path } })
end

local function find_or_git_files()
  local builtin = require('telescope.builtin')
  builtin.find_files({
    find_command = {
      'rg',
      '--hidden',
      '--files',
      '--color',
      'never',
      '-g',
      string.format('!{%s}', table.concat(ignore_glob, ',')),
    },
  })
end

local actions = require('telescope.actions')
local layout_actions = require('telescope.actions.layout')
local map = vim.keymap.set

-- Search
map('n', '<C-p>', find_or_git_files)
map('n', '<leader>/', '<CMD>Telescope live_grep<CR>')
map('n', '<leader>?', '<CMD>Telescope grep_string<CR>')
map('x', '<leader>sr', '<CMD>Telescope resume<CR>') -- Search and replace
map('n', '<leader>s?', grep_string_in_path)
map('n', '<leader>sf', find_files_in_path)
map('n', '<leader>s/', live_grep_in_path)

return {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
      '-g',
      string.format('!{%s}', table.concat(ignore_glob, ',')),
    },
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-s>'] = actions.file_split,
        ['<C-p>'] = layout_actions.toggle_preview,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
      },
      n = {
        ['<C-c>'] = actions.close,
        ['q'] = actions.close,
      },
    },
    sorting_strategy = 'ascending',
    prompt_title = '',
    preview_title = '',
    results_title = '',
    prompt_prefix = ' ',
    preview = {
      hide_on_startup = false,
    },
    selection_caret = ' ',
    entry_prefix = ' ',
    layout_strategy = 'bottom_pane',
    border = true,
    layout_config = {
      prompt_position = 'top',
      preview_width = 0.5,
      height = 25,
      width = 1,
    },
    borderchars = {
      prompt = { '─', '', '─', '', '─', '─', '', '' },
      results = { '' },
      preview = { '', '', '', '│', '│', '', '', '│' },
    },
    file_ignore_patterns = { 'node_modules' },
    path_display = { 'truncate' },
  },
  pickers = {
    find_files = {
      prompt_title = '',
      preview_title = '',
      preview = {
        hide_on_startup = false,
      },
    },
    buffers = {
      prompt_title = '',
      preview_title = '',
      entry_maker = require('plugins.configs.telescope.make_entry').make_buffers_entry(),
      preview = {
        hide_on_startup = false,
      },
      mappings = {
        i = {
          ['<C-x>'] = 'delete_buffer',
        },
        n = {
          ['<C-x>'] = 'delete_buffer',
        },
      },
    },
    lsp_references = {
      prompt_title = '',
      preview_title = '',
      preview = {
        hide_on_startup = false,
      },
      layout_config = {
        width = 0.95,
      },
    },
    git_files = {
      prompt_title = '',
      preview_title = '',
    },
    grep_string = {
      prompt_title = '',
      preview_title = '',
      preview = {
        hide_on_startup = false,
      },
      layout_config = {
        width = 0.98,
        height = 0.95,
      },
    },
    live_grep = {
      prompt_title = '',
      preview_title = '',
      preview = {
        hide_on_startup = false,
      },
      layout_config = {
        width = 0.95,
      },
    },
    lsp_document_symbols = {
      prompt_title = '',
      preview_title = '',
    },
    lsp_workspace_symbols = {
      prompt_title = '',
      preview_title = '',
    },
    current_buffer_fuzzy_find = {
      prompt_title = '',
      preview_title = '',
      previewer = false,
      layout_config = {
        height = 0.5,
        width = 0.7,
      },
      theme = 'dropdown',
    },
  },
}
