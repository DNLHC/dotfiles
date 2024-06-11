local ignore_glob = {
  '**/.git/*',
  '**/.hg/*',
  '**/node_modules/*',
  '**/dist/*',
  '**/vendor/*',
  '**/.svn/*',
  '**/CVS',
  '*.min.*',
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

-- Keymaps
-- map('n', '<C-p>', find_or_git_files)
-- map('n', '<leader>/', '<CMD>Telescope live_grep<CR>')
-- map('n', '<leader>?', '<CMD>Telescope grep_string<CR>')
-- map('n', '<leader><leader>', '<CMD>Telescope resume<CR>')
-- map('n', '<leader>s?', grep_string_in_path)
-- map('n', '<leader>sf', find_files_in_path)
-- map('n', '<leader>s/', live_grep_in_path)
map('n', '<C-p>', function()
  require('telescope').extensions.smart_open.smart_open({
    cwd_only = true,
  })
end)

return {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    smart_open = {
      match_algorithm = 'fzf',
      disable_devicons = true,
      ignore_patterns = vim.tbl_extend('force', {
        '*.git/*',
        '*build/*',
        '*debug/*',
        '*.pdf',
        '*.ico',
        '*.class',
        '*~',
        '~:',
        '*.jar',
        '*.node',
        '*.lock',
        '*.gz',
        '*.zip',
        '*.7z',
        '*.rar',
        '*.lzma',
        '*.bz2',
        '*.rlib',
        '*.rmeta',
        '*.DS_Store',
        '*.cur',
        '*.png',
        '*.jpeg',
        '*.jpg',
        '*.gif',
        '*.bmp',
        '*.avif',
        '*.heif',
        '*.jxl',
        '*.tif',
        '*.tiff',
        '*.ttf',
        '*.otf',
        '*.woff*',
        '*.sfd',
        '*.pcf',
        '*.ico',
        '*.svg',
        '*.ser',
        '*.wasm',
        '*.pack',
        '*.pyc',
        '*.apk',
        '*.bin',
        '*.dll',
        '*.pdb',
        '*.db',
        '*.so',
        '*.spl',
        '*.min.js',
        '*.min.gzip.js',
        '*.so',
        '*.doc',
        '*.swp',
        '*.bak',
        '*.ctags',
        '*.doc',
        '*.ppt',
        '*.xls',
        '*.pdf',
      }, ignore_glob),
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
        ['<C-w>'] = nil,
      },
      n = {
        ['<C-c>'] = actions.close,
        ['q'] = actions.close,
      },
    },
    sorting_strategy = 'ascending',
    prompt_prefix = ' ',
    preview = {
      hide_on_startup = false,
    },
    selection_caret = ' ',
    entry_prefix = ' ',
    layout_strategy = 'flex',
    layout_config = {
      horizontal = {
        size = {
          width = '100%',
          height = '33%',
        },
      },
      vertical = {
        size = {
          width = '90%',
          height = '90%',
        },
      },
    },
    create_layout = require('plugins.configs.telescope.make_popup'),
    file_ignore_patterns = { 'node_modules' },
    path_display = { 'truncate' },
  },
  pickers = {
    buffers = {
      entry_maker = require('plugins.configs.telescope.make_entry').make_buffers_entry(),
      mappings = {
        i = {
          ['<C-x>'] = 'delete_buffer',
        },
        n = {
          ['<C-x>'] = 'delete_buffer',
        },
      },
    },
  },
}
