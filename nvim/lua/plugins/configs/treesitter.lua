return {
  ensure_installed = {
    'bash',
    'css',
    'diff',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'tsx',
    'typescript',
    'vimdoc',
    'vue',
    'yaml',
  },
  endwise = {
    enable = true,
  },
  autotag = {
    enable = true,
    enable_close_on_slash = false,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function()
      return vim.b.large_buf
    end,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
      },
    },
    move = {
      enable = false,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}
