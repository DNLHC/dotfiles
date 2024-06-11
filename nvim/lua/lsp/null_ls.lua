local M = {}

local CSPELL_CONFIG_FILES = {
  'cspell.json',
  '.cspell.json',
  'cSpell.json',
  '.cspell.json',
  '.cspell.config.json',
}

---@param filename string
---@param cwd string
---@return string|nil
local function find_file(filename, cwd)
  ---@type string|nil
  local current_dir = cwd
  local root_dir = '/'

  repeat
    local file_path = current_dir .. '/' .. filename
    local stat = vim.loop.fs_stat(file_path)
    if stat and stat.type == 'file' then
      return file_path
    end

    current_dir = vim.loop.fs_realpath(current_dir .. '/..')
  until current_dir == root_dir

  return nil
end

--- Find the first cspell.json file in the directory tree
---@param cwd string
---@return string|nil
local find_cspell_config_path = function(cwd)
  for _, file in ipairs(CSPELL_CONFIG_FILES) do
    local path = find_file(file, cwd or vim.loop.cwd())
    if path then
      return path
    end
  end
  return nil
end

--- Find the project .vscode directory, if any
---@param cwd string
---@return string|nil
local function find_vscode_config_dir(cwd)
  ---@type string|nil
  local current_dir = cwd
  local root_dir = '/'

  repeat
    local dir_path = current_dir .. '/.vscode'
    local stat = vim.loop.fs_stat(dir_path)

    if stat and stat.type == 'directory' then
      return dir_path
    end

    current_dir = vim.loop.fs_realpath(current_dir .. '/..')
  until current_dir == root_dir

  return nil
end

function M.setup(on_attach)
  local present, null_ls = pcall(require, 'null-ls')

  if not present then
    return
  end

  local builtins = null_ls.builtins
  local diagnostics = builtins.diagnostics
  local eslint_d_diagnostics = require('none-ls.diagnostics.eslint_d')
  local eslint_d_code_actions = require('none-ls.code_actions.eslint_d')
  local cspell = require('cspell')

  local cspell_config = {
    find_json = function(cwd)
      local vscode_dir = find_vscode_config_dir(cwd)

      if vscode_dir ~= nil then
        local vscode_cspell_config = find_cspell_config_path(vscode_dir)

        if vscode_cspell_config ~= nil then
          return vscode_cspell_config
        end
      end

      local local_cspell_config = find_cspell_config_path(cwd)

      if local_cspell_config ~= nil then
        return local_cspell_config
      end

      return vim.fn.expand('$HOME') .. '/cspell.json'
    end,

    -- decode_json = require('json5').parse,
  }

  null_ls.setup({
    sources = {
      eslint_d_code_actions,
      diagnostics.stylelint.with({
        extra_filetypes = { 'pcss', 'astro' },
      }),
      eslint_d_diagnostics.with({
        extra_args = { '--no-error-on-unmatched-pattern' }, -- don't remember why but it's there
      }),
      -- cspell.diagnostics.with({ config = cspell_config }),
      -- cspell.code_actions.with({ config = cspell_config }),
    },
    debounce = 250,
    debug = false,
    on_attach = on_attach,
  })
end

return M
