---@diagnostic disable: different-requires
local common_plugins = {
  'tpope/vim-repeat',
  {
    'kylechui/nvim-surround',
    keys = {
      'ys',
      'yS',
      'cs',
      'ds',
      { 'S', mode = 'x' },
    },
    opts = {},
  },
  {
    'echasnovski/mini.jump',
    keys = {
      { 'F', mode = { 'n', 'x' } },
      { 'f', mode = { 'n', 'x' } },
      { 't', mode = { 'n', 'x' } },
      { 'T', mode = { 'n', 'x' } },
    },
    opts = {
      mappings = {
        repeat_jump = '',
      },
      delay = {
        -- Delay between jump and highlighting all possible jumps
        highlight = 250,
        -- Delay between jump and automatic stop if idle (no jump is done)
        idle_stop = 10000000,
      },
    },
  },
}

local cli_plugins = {
  {
    'tpope/vim-unimpaired',
    keys = {
      { '[', mode = { 'x', 'n' } },
      { ']', mode = { 'x', 'n' } },
    },
  },
  {
    'lambdalisue/vim-suda',
    cmd = { 'SudaRead', 'SudaWrite' },
  },
  {
    'danielfalk/smart-open.nvim',
    branch = '0.2.x',
    dependencies = {
      'kkharji/sqlite.lua',
    },
  },
  'lewis6991/impatient.nvim',
  'ojroques/nvim-osc52',
  'tpope/vim-sleuth',
  { 'tpope/vim-fugitive' },
  {
    'ibhagwan/fzf-lua',
    config = function()
      local actions = require('fzf-lua').actions

      local function find_files_in_path(path)
        local _path = path or vim.fn.input('cwd: ', '', 'dir')
        require('fzf-lua').files({ cwd = _path })
      end

      local function live_grep_glob_in_path(path)
        local _path = path or vim.fn.input('cwd: ', '', 'dir')
        require('fzf-lua').files({ cwd = _path })
      end

      vim.keymap.set('n', '<leader>/', '<CMD>FzfLua live_grep_glob<CR>')
      vim.keymap.set('n', '<leader>bb', '<CMD>FzfLua buffers<CR>')
      vim.keymap.set('n', '<leader><leader>', '<CMD>FzfLua resume<CR>')
      vim.keymap.set('n', '<C-f>', '<CMD>FzfLua files<CR>')
      vim.keymap.set('n', '<leader>sf', find_files_in_path)
      vim.keymap.set('n', '<leader>?', live_grep_glob_in_path)
      vim.keymap.set('n', '<C-g>', '<CMD>FzfLua grep_cword<CR>')
      vim.keymap.set('v', '<C-g>', '<CMD>FzfLua grep_visual<CR>')

      require('fzf-lua').setup({
        defaults = {
          file_icons = false,
          -- git_icons = true,
          prompt = 'pattern: ',
          cwd_prompt = false,
          no_header = true,
          input_prompt = 'pattern: ',
        },
        fzf_opts = {
          ['--pointer'] = '▌',
          ['--highlight-line'] = true,
          ['--tabstop'] = 2,
          ['--marker'] = '+',
          ['--marker-multi-line'] = '┃┃┃',
          ['--no-scrollbar'] = true,
        },
        hls = {
          normal = 'TelescopeNormal',
          border = 'TelescopeBorder',
          help_normal = 'TelescopeNormal',
          help_border = 'TelescopeBorder',
          preview_normal = 'TelescopeNormal',
          preview_border = 'TelescopeBorder',
          -- builtin preview only
          cursor = 'Cursor',
          cursorline = 'CursorLine',
          cursorlinenr = 'CursorLineNr',
          search = 'IncSearch',
        },
        fzf_colors = {
          ['fg'] = { 'fg', 'TelescopeNormal' },
          ['bg'] = { 'bg', 'TelescopeNormal' },
          ['hl'] = { 'fg', 'Function' },
          ['fg+'] = { 'fg', 'Normal' },
          ['bg+'] = { 'bg', 'TelescopeSelection' },
          ['hl+'] = { 'fg', 'Function' },
          ['info'] = { 'fg', 'TelescopeNormal' },
          -- conflicts with rg bg colors `path` and `line`
          -- ['selected-bg'] = { 'bg', 'TelescopeMultiSelection' },
          ['border'] = { 'fg', 'TelescopeBorder' },
          ['gutter'] = { 'bg', 'TelescopeNormal' },
          ['query'] = { 'fg', 'TelescopePromptNormal' },
          ['separator'] = { 'bg', 'Normal' },
          ['prompt'] = { 'fg', 'TelescopePromptPrefix' },
          ['pointer'] = { 'fg', 'TelescopeSelectionCaret' },
          ['marker'] = { 'fg', 'TelescopeSelectionCaret' },
          ['header'] = { 'fg', 'TelescopeTitle' },
        },
        winopts = {
          split = 'bot new | resize 20',
          border = { '│', '', '', '', '', '', '│', '│' },
          preview = {
            title = false,
            scrollbar = false,
            horizontal = 'right:55%',
            wrap = 'wrap',
            border = 'noborder',
            winopts = {
              number = false,
            },
          },
        },
        keymap = {
          builtin = {
            ['<F1>'] = 'toggle-help',
            ['<F2>'] = 'toggle-fullscreen',
            -- Only valid with the 'builtin' previewer
            ['<F3>'] = 'toggle-preview-wrap',
            ['<F4>'] = 'toggle-preview',
            ['<F5>'] = 'toggle-preview-ccw',
            ['<F6>'] = 'toggle-preview-cw',
            ['<C-d>'] = 'preview-page-down',
            ['<C-u>'] = 'preview-page-up',
            ['<S-left>'] = 'preview-page-reset',
          },
          fzf = {
            ['ctrl-z'] = 'abort',
            ['ctrl-f'] = 'half-page-down',
            ['ctrl-b'] = 'half-page-up',
            ['ctrl-a'] = 'beginning-of-line',
            ['ctrl-e'] = 'end-of-line',
            ['alt-a'] = 'toggle-all',
            -- Only valid with fzf previewers (bat/cat/git/etc)
            ['f3'] = 'toggle-preview-wrap',
            ['f4'] = 'toggle-preview',
            ['ctrl-d'] = 'preview-page-down',
            ['ctrl-u'] = 'preview-page-up',
            ['ctrl-q'] = 'select-all+accept',
          },
        },
        actions = {
          files = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-x'] = actions.file_split,
            ['ctrl-v'] = actions.file_vsplit,
            ['ctrl-t'] = actions.file_tabedit,
            ['alt-q'] = actions.file_sel_to_qf,
            ['alt-l'] = actions.file_sel_to_ll,
          },
          buffers = {
            ['default'] = actions.buf_edit,
            ['ctrl-v'] = actions.buf_vsplit,
            ['ctrl-t'] = actions.buf_tabedit,
          },
        },
        grep = {
          -- formatter = 'path.filename_first',
          multiline = 1,
          git_icons = false,
        },
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup({
        columns = {},
        view_options = {
          show_hidden = true,
        },
        win_options = {
          statuscolumn = ' ',
        },
        -- constrain_cursor = 'name',
        keymaps = {
          ['~'] = 'actions.open_cwd',
          ['<C-q>'] = 'actions.add_to_qflist',
          ['-'] = false,
        },
      })

      vim.keymap.set('n', '<C-n>', '<CMD>Oil<CR>')
    end,
  },
  'nvim-lua/plenary.nvim',
  {
    'mbbill/undotree',
    cmd = { 'UndotreeToggle' },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 0
      vim.g.undotree_DiffpanelHeight = 15
      vim.g.undotree_SplitWidth = 35
    end,
  },
  {
    'kosayoda/nvim-lightbulb',
    enabled = false,
    opts = {
      autocmd = { enabled = true },
      sign = {
        enable = true,
        text = require('core.globals').code_action_sign,
        hl = '',
      },
    },
  },
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance',
    dev = true,
    opts = function()
      return require('plugins.configs.glance')
    end,
  },
  {
    'rmagatti/auto-session',
    opts = { log_level = 'error' },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
    init = function()
      if vim.fn.has('nvim-0.10') == 1 then
        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
          return option == 'commentstring'
              and require('ts_context_commentstring.internal').calculate_commentstring()
            or get_option(filetype, option)
        end
      end
    end,
  },
  {
    'echasnovski/mini.comment',
    version = false,
    enabled = vim.fn.has('nvim-0.10') == 0,
    keys = {
      { 'gc', mode = { 'x', 'n' } },
    },
    opts = function()
      return {
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring').calculate_commentstring()
              or vim.bo.commentstring
          end,
        },
      }
    end,
    config = function(_, opts)
      vim.g.skip_ts_context_commentstring_module = true
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })
      require('mini.comment').setup(opts)
    end,
  },
  {
    'echasnovski/mini.pairs',
    event = { 'InsertEnter' },
    opts = {
      mappings = {
        [' '] = {
          action = 'open',
          pair = '  ',
          neigh_pattern = '[%(%[{][%)%]}]',
        },
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = function()
      return require('plugins.configs.lualine')
    end,
    config = function(_, opts)
      require('lualine').setup(opts)
    end,
  },
  { 'echasnovski/mini.bufremove', lazy = true },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        enabled = vim.fn.executable('make') == 1,
      },
      'MunifTanjim/nui.nvim',
    },
    opts = function()
      return require('plugins.configs.telescope')
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension('smart_open')
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      func_map = {
        split = '<C-s>',
      },
      filter = {
        fzf = {
          action_for = { ['ctrl-s'] = 'split' },
        },
      },
      preview = {
        auto_preview = true,
        show_title = false,
        win_height = 15,
        winblend = 0,
        border = { ' ', '─', ' ', ' ', ' ', ' ', ' ', ' ' },
        should_preview_cb = function(bufnr)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 150 * 1024 then
            -- skip file size greater than 150kb
            return false
          elseif bufname:match('^fugitive://') then
            -- skip fugitive buffer
            return false
          end
          return true
        end,
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = function()
      return require('plugins.configs.gitsigns')
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    event = 'BufReadPre',
    version = false,
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = {
            pattern = '%f[%w]()FIXME()%f[%W]',
            group = 'MiniHipatternsFixme',
          },
          hack = {
            pattern = '%f[%w]()HACK()%f[%W]',
            group = 'MiniHipatternsHack',
          },
          todo = {
            pattern = '%f[%w]()TODO()%f[%W]',
            group = 'MiniHipatternsTodo',
          },
          note = {
            pattern = '%f[%w]()NOTE()%f[%W]',
            group = 'MiniHipatternsNote',
          },
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
      local augroup =
        vim.api.nvim_create_augroup('HiPatternsFiletype', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = augroup,
        pattern = {
          'help',
          'NvimTree',
          'qf',
          'lspinfo',
          'tsplayground',
          'query',
          'checkhealth',
          'lazy',
          'fugitive',
          'toggleterm',
        },
        command = 'lua vim.b.minihipatterns_disable = true',
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
    },
    opts = function()
      return require('plugins.configs.treesitter')
    end,
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'pmizio/typescript-tools.nvim',
      'b0o/schemastore.nvim',
    },
    config = function()
      require('lsp').config()
    end,
  },
  {
    'stevearc/conform.nvim',
    cmd = { 'Format', 'FormatEnable', 'FormatDisable' },
    event = { 'BufWritePre' },
    lazy = true,
    config = function()
      require('plugins.configs.conform').setup()
    end,
  },
  {
    'davidmh/cspell.nvim',
    dependencies = { 'Joakker/lua-json5' },
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      {
        'zbirenbaum/copilot-cmp',
        enabled = false,
        config = function()
          require('copilot_cmp').setup()
        end,
      },
    },
    config = function()
      require('plugins.configs.cmp')
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    enabled = false,
    event = 'InsertEnter',
    opts = {
      copilot_node_command = vim.fn.expand('$HOME')
        .. '/.volta/tools/image/node/20.9.0/bin/node',
    },
    config = function(_, opts)
      require('copilot').setup(opts)
    end,
  },
}

if not vim.g.vscode then
  for i = 1, #cli_plugins do
    common_plugins[#common_plugins + 1] = cli_plugins[i]
  end
end

return common_plugins
