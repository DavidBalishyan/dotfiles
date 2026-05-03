-- Check for missing LSP server binaries and notify user

local M = {}

local installers = {
  lua_ls = {
    cmd = 'lua-language-server',
    install = 'brew install lua-language-server',
  },
  pyright = {
    cmd = 'pyright-langserver',
    install = 'pip install pyright',
  },
  ts_ls = {
    cmd = 'typescript-language-server',
    install = 'npm i -g typescript-language-server typescript',
  },
  tailwindcss = {
    cmd = 'tailwindcss-language-server',
    install = 'npm i -g @tailwindcss/language-server',
  },
  gopls = {
    cmd = 'gopls',
    install = 'go install golang.org/x/tools/gopls@latest',
  },
  rust_analyzer = {
    cmd = 'rust-analyzer',
    install = 'rustup component add rust-analyzer',
  },
  phpactor = {
    cmd = 'phpactor',
    install = 'composer global require phpactor/phpactor',
  },
  bashls = {
    cmd = 'bash-language-server',
    install = 'npm i -g bash-language-server',
  },
  clangd = {
    cmd = 'clangd',
    install = 'sudo apt install clangd    (or: brew install llvm)',
  },
  ruby_lsp = {
    cmd = 'ruby-lsp',
    install = 'gem install ruby-lsp',
  },
}

function M.ensure_all()
  local missing = {}
  for name, info in pairs(installers) do
    if vim.fn.executable(info.cmd) == 0 then
      table.insert(missing, { name = name, install = info.install })
    end
  end
  if #missing > 0 then
    local lines = { 'Missing LSP servers:' }
    for _, m in ipairs(missing) do
      table.insert(lines, string.format('  %s  ->  %s', m.name, m.install))
    end
    vim.schedule(function()
      vim.notify(table.concat(lines, '\n'), vim.log.levels.WARN)
    end)
  end
end

return M
