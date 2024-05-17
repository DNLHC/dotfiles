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
  {
    'tpope/vim-unimpaired',
    keys = {
      { '[', mode = { 'x', 'n' } },
      { ']', mode = { 'x', 'n' } },
    },
  },
  'lewis6991/impatient.nvim',
  'ojroques/nvim-osc52',
  'tpope/vim-sleuth',
  { cmd = 'Git', 'tpope/vim-fugitive' },
  'nvim-lua/plenary.nvim',
  {
    'L3MON4D3/LuaSnip',
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
    'kosayoda/nvim-lightbulb',
    enabled = true,
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
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    version = false,
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
    cmd = 'Telescope',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        enabled = vim.fn.executable('make') == 1,
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
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 100k
            ret = false
          elseif bufname:match('^fugitive://') then
            -- skip fugitive buffer
            ret = false
          end
          return ret
        end,
      },
    },
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
      'jose-elias-alvarez/typescript.nvim',
      'b0o/schemastore.nvim',
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
