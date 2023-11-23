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
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(_, buf)
      local max_filesize = 150 * 1024 -- 150 KB
      local max_minified_filesize = 10 * 1024 -- 10 KB
      local lcount = vim.api.nvim_buf_line_count(buf)
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

      if not ok or not stats then
        return true
      end

      if stats.size > max_filesize then
        return true
      end

      if lcount == 1 and stats.size > max_minified_filesize then
        return true
      end
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
