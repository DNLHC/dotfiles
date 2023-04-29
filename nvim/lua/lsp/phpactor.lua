local M = {}
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local lspcontainers = require('lspcontainers')

function M.setup(options)
  lspconfig.phpactor.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    filetypes = { 'php' },
    init_options = {
      ['language_server_phpstan.enabled'] = false,
      ['language_server_psalm.enabled'] = false,
    },
    cmd = lspcontainers.command('phpactor', {
      image = 'docker.io/library/phpactor',
      cmd = function(runtime, volume, image)
        return {
          runtime,
          'container',
          'run',
          '--interactive',
          '--rm',
          '--volume',
          volume,
          image,
        }
      end,
    }),
    root_dir = function(pattern)
      local cwd = vim.loop.cwd()
      local root = util.root_pattern('composer.json', '.git')(pattern)

      -- prefer cwd if root is a descendant
      return util.path.is_descendant(cwd, root) and cwd or root
    end,
  })
end

return M
