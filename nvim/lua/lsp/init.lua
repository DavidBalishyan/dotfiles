-- Built-in LSP setup - no mason, no wrappers

local api = vim.api
local lsp = vim.lsp

-- lazydev setup for Lua LSP on Neovim config files
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- Diagnostic config
local sev = vim.diagnostic.severity
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = sev.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [sev.ERROR] = '󰅚 ',
      [sev.WARN] = '󰀪 ',
      [sev.INFO] = '󰋽 ',
      [sev.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}

-- Server configurations
local servers = {
  -- 1. Lua
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
        diagnostics = { globals = { 'vim' } },
      },
    },
  },

  -- 2. Python
  pyright = {},

  -- 3. JavaScript / TypeScript
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
          languages = { 'javascript', 'typescript', 'typescriptreact' },
        },
      },
    },
  },

  -- 4. Tailwind CSS
  tailwindcss = {
    filetypes = {
      'html', 'php', 'css', 'less', 'sass', 'scss',
      'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
      'svelte', 'vue', 'templ', 'heex', 'elixir', 'astro',
    },
  },

  -- 5. Go
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
      },
    },
  },

  -- 6. Rust
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        cargo = { buildScripts = { enable = true } },
        diagnostics = { enable = true },
        procMacro = { enable = true },
      },
    },
  },

  -- 7. PHP
  phpactor = {},

  -- 8. Bash
  bashls = {},

  -- 9. C / C++
  clangd = {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
  },

  -- 10. Ruby
  ruby_lsp = {},
}

-- LSP attach function for buffer-local keymaps and features
local function on_attach(client, bufnr)
  local map = function(mode, key, func, desc)
    vim.keymap.set(mode, key, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  map('n', 'grn', lsp.buf.rename, '[R]e[n]ame')
  map('n', 'gra', lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  map('n', 'grr', lsp.buf.references, '[G]oto [R]eferences')
  map('n', 'gri', lsp.buf.implementation, '[G]oto [I]mplementation')
  map('n', 'grd', lsp.buf.definition, '[G]oto [D]efinition')
  map('n', 'grD', lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'grt', lsp.buf.type_definition, '[G]oto [T]ype Definition')
  map('n', 'gO', lsp.buf.document_symbol, 'Document Symbols')
  map('n', 'gW', lsp.buf.workspace_symbol, 'Workspace Symbols')

  if client:supports_method(lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
    map('n', '<leader>th', function()
      lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end, '[T]oggle Inlay [H]ints')
  end
end

-- Document highlight on cursor hold
local highlight_group = api.nvim_create_augroup('lsp_document_highlight', { clear = true })
api.nvim_create_autocmd('CursorHold', {
  group = highlight_group,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(lsp.get_clients { bufnr = bufnr }) do
      if client:supports_method(lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
        lsp.buf.document_highlight()
        return
      end
    end
  end,
})

api.nvim_create_autocmd('CursorMoved', {
  group = highlight_group,
  callback = function()
    lsp.buf.clear_references()
  end,
})

-- Check for missing LSP servers and notify
require('lsp.installer').ensure_all()

-- Setup and enable servers (skip gracefully if binary missing)
for server, config in pairs(servers) do
  config.on_attach = on_attach
  lsp.config(server, config)
  pcall(lsp.enable, server)
end
