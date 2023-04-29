---@diagnostic disable: different-requires
return {
  'lewis6991/impatient.nvim',
  'ojroques/nvim-osc52',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-unimpaired',
  { cmd = 'Git', 'tpope/vim-fugitive' },
  'nvim-lua/plenary.nvim',
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = { char = '▏' },
    config = function(_, opts)
      require('indent_blankline').setup(opts)
    end,
  },
  {
    '~/projects/nvim-pqf',
    dev = true,
    config = function()
      require('pqf').setup()
    end,
  },
  {
    'kosayoda/nvim-lightbulb',
    opts = {
      autocmd = { enabled = true },
      sign = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('nvim-lightbulb').setup(opts)
      vim.fn.sign_define('LightBulbSign', {
        text = require('core.globals').code_action_sign,
        texthl = '',
        linehl = '',
        numhl = '',
      })
    end,
  },
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance',
    dev = true,
    opts = function()
      return require('plugins.configs.glance')
    end,
    config = function(_, opts)
      require('glance').setup(opts)
    end,
  },
  {
    'rmagatti/auto-session',
    opts = { log_level = 'error' },
    config = function(_, opts)
      require('auto-session').setup(opts)
    end,
  },
  {
    'kylechui/nvim-surround',
    keys = {
      'ys',
      'yS',
      'cs',
      'ds',
      { 'S', mode = 'x' },
    },
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'x', 'n' } },
      { 'gb', mode = { 'x', 'n' } },
    },
    opts = function()
      return require('plugins.configs.comment')
    end,
    config = function(_, opts)
      require('Comment').setup(opts)
    end,
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
  {
    'kyazdani42/nvim-tree.lua',
    version = 'nightly',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    opts = function()
      return require('plugins.configs.nvim_tree')
    end,
    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    opts = function()
      return require('plugins.configs.toggleterm')
    end,
    config = function(_, opts)
      require('toggleterm').setup(opts)

      local Terminal = require('toggleterm.terminal').Terminal
      local tab_terminal = Terminal:new({
        direction = 'tab',
        close_on_exit = false,
      })

      vim.keymap.set('n', '<leader>tt', function()
        tab_terminal:toggle()
      end)
    end,
  },
  { 'echasnovski/mini.bufremove', lazy = true },
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
    config = function(_, opts)
      require('mini.jump').setup(opts)
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    opts = function()
      return require('plugins.configs.telescope')
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    opts = function()
      return require('plugins.configs.nvim_bqf')
    end,
    config = function(_, opts)
      require('bqf').setup(opts)
    end,
  },
  -- 'tpope/vim-dadbod',
  -- 'kristijanhusak/vim-dadbod-completion',
  -- {
  --   'kristijanhusak/vim-dadbod-ui',
  --   config = function()
  --     vim.g.db_ui_auto_execute_table_helpers = 1
  --     vim.g.db_ui_show_help = 0
  --     local globals = require('core.globals')
  --     vim.g.db_ui_icons = {
  --       expanded = globals.arrow_open,
  --       collapsed = globals.arrow_closed,
  --       saved_query = '*',
  --       new_query = '+',
  --       tables = '~',
  --       buffers = '»',
  --       connection_ok = '✓',
  --       connection_error = '✕',
  --     }
  --   end,
  -- },

  {
    'lewis6991/gitsigns.nvim',
    opts = function()
      return require('plugins.configs.gitsigns')
    end,
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewFileHistory', 'DiffviewOpen', 'DiffviewLog' },
    opts = function()
      return require('plugins.configs.diffview')
    end,
    config = function(_, opts)
      require('diffview').setup(opts)
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    init = function()
      vim.schedule(function()
        require('lazy').load({ plugins = 'nvim-colorizer.lua' })
      end, 0)
    end,
    config = function()
      require('colorizer').setup({
        '*',
        '!packer',
        '!lazy',
        css = { rgb_fn = true },
      }, {
        names = false,
        RRGGBBAA = true,
      })

      vim.defer_fn(function()
        require('colorizer').attach_to_buffer(0)
      end, 0)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'JoosepAlviste/nvim-ts-context-commentstring',
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
  'b0o/schemastore.nvim',
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'jose-elias-alvarez/typescript.nvim',
    },
    config = function()
      require('lsp').config()
    end,
  },
  'jose-elias-alvarez/null-ls.nvim',
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      {
        'windwp/nvim-autopairs',
        opts = {
          check_ts = true,
          fast_wrap = {},
        },
        config = function(_, opts)
          local npairs = require('nvim-autopairs')
          local Rule = require('nvim-autopairs.rule')
          npairs.setup(opts)

          -- Add spaces between parentheses
          npairs.add_rules({
            Rule(' ', ' '):with_pair(function(_opts)
              local pair = _opts.line:sub(_opts.col - 1, _opts.col)
              return vim.tbl_contains({ '()', '[]', '{}' }, pair)
            end),
            Rule('( ', ' )')
              :with_pair(function()
                return false
              end)
              :with_move(function(_opts)
                return _opts.prev_char:match('.%)') ~= nil
              end)
              :use_key(')'),
            Rule('{ ', ' }')
              :with_pair(function()
                return false
              end)
              :with_move(function(_opts)
                return _opts.prev_char:match('.%}') ~= nil
              end)
              :use_key('}'),
            Rule('[ ', ' ]')
              :with_pair(function()
                return false
              end)
              :with_move(function(_opts)
                return _opts.prev_char:match('.%]') ~= nil
              end)
              :use_key(']'),
          })
        end,
      },
      {
        'zbirenbaum/copilot.lua',
        opts = {
          copilot_node_command = vim.fn.expand('$HOME')
            .. '/.volta/tools/image/node/16.20.0/bin/node',
        },
        config = function(_, opts)
          require('copilot').setup(opts)
        end,
      },
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
      {
        'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        config = function(_, opts)
          local luasnip = require('luasnip')
          luasnip.config.set_config(opts)
          luasnip.filetype_extend('typescript', { 'javascript' })
          luasnip.filetype_extend('typescriptreact', { 'javascript' })
        end,
      },
    },
    config = function()
      require('plugins.configs.cmp')
    end,
  },
}
