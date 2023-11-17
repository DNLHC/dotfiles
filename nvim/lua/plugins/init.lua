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
    config = function()
      require('nvim-surround').setup({})
    end,
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
    config = function(_, opts)
      require('mini.jump').setup(opts)
    end,
  },
}

local cli_plugins = {
  'tpope/vim-unimpaired',
  'lewis6991/impatient.nvim',
  'ojroques/nvim-osc52',
  'tpope/vim-sleuth',
  { cmd = 'Git', 'tpope/vim-fugitive' },
  'nvim-lua/plenary.nvim',
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = '2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
  },
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
    'ThePrimeagen/harpoon',
    config = function()
      local harpoon_mark = require('harpoon.mark')
      local harpoon_ui = require('harpoon.ui')
      vim.keymap.set('n', '<leader>ha', harpoon_mark.add_file)
      vim.keymap.set('n', '<leader>hh', harpoon_ui.toggle_quick_menu)
      vim.keymap.set('n', '<C-h>', harpoon_ui.nav_prev)
      vim.keymap.set('n', '<C-l>', harpoon_ui.nav_next)
      for i = 1, 9, 1 do
        vim.keymap.set('n', '<leader>h' .. i, function()
          harpoon_ui.nav_next(i)
        end)
      end
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
        text = require('core.globals').code_action_sign,
        hl = '',
      },
    },
    config = function(_, opts)
      require('nvim-lightbulb').setup(opts)
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
    'echasnovski/mini.comment',
    version = false,
    keys = {
      { 'gc', mode = { 'x', 'n' } },
    },
    opts = function()
      return {
        hooks = {
          pre = function()
            require('ts_context_commentstring.internal').update_commentstring()
          end,
        },
      }
    end,
    config = function(_, opts)
      require('mini.comment').setup(opts)
    end,
  },
  {
    'echasnovski/mini.pairs',
    event = { 'InsertEnter' },
    version = false,
    opts = {
      mappings = {
        [' '] = {
          action = 'open',
          pair = '  ',
          neigh_pattern = '[%(%[{][%)%]}]',
        },
      },
    },
    config = function(_, opts)
      require('mini.pairs').setup(opts)
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
    'echasnovski/mini.hipatterns',
    event = 'BufReadPre',
    version = false,
    config = function(_, opts)
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
          'DiffviewFiles',
          'qf',
          'lspinfo',
          'tsplayground',
          'query',
          'checkhealth',
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
      'p00f/nvim-ts-rainbow',
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
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'davidmh/cspell.nvim' },
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
