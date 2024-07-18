---@diagnostic disable: different-requires
local common_plugins = {
  { 'tpope/vim-repeat', event = 'VeryLazy' },
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
  'lewis6991/impatient.nvim',
  { 'ojroques/nvim-osc52', event = 'VeryLazy' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    event = 'VeryLazy',
    branch = 'canary',
    config = function()
      require('CopilotChat').setup({
        proxy = 'socks5://localhost:14040',
      })
    end,
  },
  {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_node_command = vim.fn.expand('$HOME')
        .. '/.volta/tools/image/node/20.14.0/bin/node'
      vim.g.copilot_proxy_strict_ssl = false
      vim.g.copilot_proxy = 'http://localhost:8123'
    end,
  },
  {
    'ibhagwan/fzf-lua',
    event = 'VeryLazy',
    config = function()
      local fzf = require('fzf-lua')
      local actions = fzf.actions

      vim.api.nvim_create_user_command('Find', function(event)
        local cwd = vim.fn.fnamemodify(event.args, ':p:h')
        if event.bang then
          fzf.live_grep_glob({ cwd = cwd })
        else
          fzf.files({ cwd = cwd })
        end
      end, {
        nargs = 1,
        complete = 'dir',
        bang = true,
      })

      vim.keymap.set('n', '<leader>/', '<CMD>FzfLua live_grep_glob<CR>')
      vim.keymap.set('n', '<leader>bb', '<CMD>FzfLua buffers<CR>')
      vim.keymap.set('n', '<leader><leader>', '<CMD>FzfLua resume<CR>')
      vim.keymap.set('n', '<C-p>', '<CMD>FzfLua files<CR>')
      -- vim.keymap.set('n', '<C-g>', '<CMD>FzfLua grep_cword<CR>')
      vim.keymap.set('v', '<C-g>', '<CMD>FzfLua grep_visual<CR>')

      local ignore_glob = {
        '**/.git/*',
        '**/.hg/*',
        '**/node_modules/*',
        '**/dist/*',
        '**/.svn/*',
        '**/CVS',
        '**/*.min.*',
        '**/package-lock.json',
        '**/yarn.lock',
        '**/*.log',
        '**/composer.lock',
        '**/.pnp.js',
      }

      fzf.setup({
        defaults = {
          file_icons = false,
          -- git_icons = true,
          multiline = 1,
          prompt = 'pattern: ',
          cwd_prompt = false,
          no_header = true,
          input_prompt = 'pattern: ',
          formatter = { 'path.filename_first', 2 },
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
          ['fg'] = { 'fg', 'Normal' },
          ['bg'] = { 'bg', 'TelescopeNormal' },
          ['hl'] = { 'fg', 'Function', 'bold' },
          ['fg+'] = { 'fg', 'Normal', 'regular' },
          ['bg+'] = { 'bg', 'TelescopeSelection' },
          ['hl+'] = { 'fg', 'Function', 'bold' },
          ['info'] = { 'fg', 'TelescopeNormal' },
          -- ['selected-bg'] = { 'bg', 'TelescopeMultiSelection' },
          ['border'] = { 'fg', 'TelescopeBorder' },
          ['gutter'] = { 'bg', 'TelescopeNormal' },
          ['query'] = { 'fg', 'TelescopePromptNormal', 'regular' },
          ['separator'] = { 'bg', 'Normal' },
          ['prompt'] = { 'fg', 'TelescopePromptPrefix', 'regular' },
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
        files = {
          git_icons = true,
        },
        buffers = {
          git_icons = false,
        },
        grep = {
          git_icons = false,
          RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
          rg_opts = table.concat({
            '--column',
            '--line-number',
            '--no-heading',
            '--color=always',
            '--smart-case',
            '--max-columns=4096',
            '-g',
            string.format('!{%s}', table.concat(ignore_glob, ',')),
            '-e',
          }, ' '),
        },
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    keys = { '<C-n>' },
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
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 0
      vim.g.undotree_DiffpanelHeight = 15
      vim.g.undotree_SplitWidth = 35
    end,
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
    event = 'VeryLazy',
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
  { 'echasnovski/mini.bufremove', lazy = true },
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
    event = 'VeryLazy',
    opts = function()
      return require('plugins.configs.gitsigns')
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    event = 'VeryLazy',
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
    event = 'VeryLazy',
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
    },
    config = function()
      require('plugins.configs.cmp')
    end,
  },
}

if not vim.g.vscode then
  for i = 1, #cli_plugins do
    common_plugins[#common_plugins + 1] = cli_plugins[i]
  end
end

return common_plugins
