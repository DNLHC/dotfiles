local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local configs = {
  emmet_ls = {
    filetypes = {
      'html',
      'css',
      'pcss',
      'sass',
      'scss',
      'less',
    },
  },
  vuels = {
    settings = {
      vetur = {
        ignoreProjectWarning = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          disable = { 'need-check-nil' },
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = {
          enable = true,
        },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemas = require('schemastore').yaml.schemas(),
        validate = {
          enable = true,
        },
        keyOrdering = false,
      },
    },
  },
}

return configs
