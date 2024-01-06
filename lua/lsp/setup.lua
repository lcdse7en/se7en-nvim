-- Setup installer & lsp configs
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')
local mason_tool_installer = require 'mason-tool-installer'

if not mason_ok or not mason_lsp_ok then
  return
end

require('neoconf').setup()
require('neodev').setup {
  override = function(_, library)
    library.enabled = true
    library.plugins = true
  end,
  lspconfig = true,
  pathStrict = true,
}
require('fidget').setup()
-- require("lspsaga").setup()

--  NOTE: mason
mason.setup {}

--  NOTE: mason_lsp
mason_lsp.setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = {
    'bashls',
    'jsonls',
    'cssls',
    'html',
    'tsserver',
    'jdtls',
    'vimls',
    'pyright',
    'intelephense',
    'eslint',
    'graphql',
    'lua_ls',
    'emmet_ls',
    'prismals',
    'typst_lsp',
    -- 'marksman',
    'clangd',
    'tailwindcss',
    'svelte',
    -- "ltex",
    'texlab',
    'gopls',
    'efm',
    'rust_analyzer',
    'yamlls',
    -- "ruff_ls",
    'dockerls',
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true,
}

--  NOTE: mason_tool_installer
mason_tool_installer.setup {
  ensure_installed = {
    --  NOTE: Forma
    'shfmt', -- shell formatter
    'black',
    'isort',
    'prettier', -- prettier formatter
    'prettierd', -- prettierd formatter
    'clang-format', -- c | cpp formatter
    'gopls',
    'gofumpt',
    -- "goimports",
    'jq',
    -- "latexindent",
    'bibtex-tidy',
    -- "luacheck",
    'stylua', -- lua formatter
    --  NOTE: Lint
    'pylint', -- python linter
    'eslint_d', -- eslint linter
  },
}

local lspconfig = require 'lspconfig'

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = 'rounded',
  }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
  ['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }
  ),
}

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.
end

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.offsetEncoding = { 'utf-16' }
capabilities.experimental = { localDocs = true }

-- Order matters

lspconfig.tsserver.setup {
  capabilities = require('lsp.servers.tsserver').capabilities,
  handlers = require('lsp.servers.tsserver').handlers,
  on_attach = require('lsp.servers.tsserver').on_attach,
  settings = require('lsp.servers.tsserver').settings,
}

-- lspconfig.tailwindcss.setup {
--   capabilities = require("lsp.servers.tailwindcss").capabilities,
--   filetypes = require("lsp.servers.tailwindcss").filetypes,
--   handlers = handlers,
--   init_options = require("lsp.servers.tailwindcss").init_options,
--   on_attach = require("lsp.servers.tailwindcss").on_attach,
--   settings = require("lsp.servers.tailwindcss").settings,
-- }

lspconfig.cssls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = require('lsp.servers.cssls').on_attach,
  settings = require('lsp.servers.cssls').settings,
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = require('lsp.servers.eslint').on_attach,
  settings = require('lsp.servers.eslint').settings,
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.servers.jsonls').settings,
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  filetypes = { 'lua' },
  cmd = { 'lua-language-server' },
  settings = require('lsp.servers.lua_ls').settings,
}

lspconfig.vuels.setup {
  filetypes = require('lsp.servers.vuels').filetypes,
  handlers = handlers,
  init_options = require('lsp.servers.vuels').init_options,
  on_attach = require('lsp.servers.vuels').on_attach,
  settings = require('lsp.servers.vuels').settings,
}

-- Add
lspconfig.bashls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  filetypes = { 'sh' },
  cmd = { 'bash-language-server', 'start' },
  settings = {
    bashIde = {
      globPattern = '*@(.sh|.inc|.bash|.command)',
    },
  },
}

lspconfig.pyright.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.servers.pyright').settings,
}

lspconfig.typst_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
  cmd = { 'typst-lsp' },
  filetypes = { 'typ', 'typst' },
  settings = {
    -- exportPdf = "onType",
    -- exportPdf = "onSave",
    exportPdf = 'never',
  },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  flags = { debounce_text_changes = 500 },
  cmd = { 'gopls', '-remote=auto' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusewrites = true,
      },
    },
  },

  --   settings = {
  --     gopls = {
  --       hints = {
  --         -- https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
  --         assignVariableTypes = true,
  --         compositeLiteralFields = true,
  --         compositeLiteralTypes = true,
  --         constantValues = true,
  --         functionTypeParameters = true,
  --         parameterNames = true,
  --         rangeVariableTypes = true,
  --       },
  --       completeUnimported = true,
  --       usePlaceholders = true,
  --       gofumpt = true,
  --       staticcheck = true,
  --       analyses = {
  --         unusedparams = true,
  --       },
  --     },
  --   },
  --   flags = {
  --     debounce_text_changes = 120,
  --   },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  -- capabilities = vim.tbl_deep_extend('keep', { offsetEncoding = { 'utf-16', 'utf-8' } }, capabilities),
  capabilities = capabilities,
  -- handlers = handlers,
  filetypes = { 'rust' },
  cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
  settings = {
    ['rust-analyzer'] = {
      procMacro = { enable = true },
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = {
        command = 'clippy', --TODO: `rustup component add clippy` to install clippy
        extraArgs = { '--no-deps' },
      },
    },
  },
}

lspconfig.texlab.setup {
  capabilities = capabilities,
  -- handlers = handlers,
  settings = {
    latex = {
      build = {
        args = {
          '-pdf',
          '-interaction=nonstopmode',
          '-synctex=1',
          '-outdir=./build',
          '%f',
        },
        outputDirectory = './build',
        onSave = true,
      },
      lint = { onChange = true },
    },
  },
  on_attach = on_attach,
  -- settings = require("lsp.servers.texlab").settings,
}

local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = require('lspconfig').util.validate_bufnr(bufnr)
  local clangd_client = require('lspconfig').util.get_active_client_by_name(bufnr, 'clangd')
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  if clangd_client then
    clangd_client.request('textDocument/switchSourceHeader', params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        vim.notify('Corresponding file can’t be determined', vim.log.levels.ERROR, { title = 'LSP Error!' })
        return
      end
      vim.api.nvim_command(splitcmd .. ' ' .. vim.uri_to_fname(result))
    end)
  else
    vim.notify(
      'Method textDocument/switchSourceHeader is not supported by any active server on this buffer',
      vim.log.levels.ERROR,
      { title = 'LSP Error!' }
    )
  end
end
local function get_binary_path_list(binaries)
  local path_list = {}
  for _, binary in ipairs(binaries) do
    local path = vim.fn.exepath(binary)
    if path ~= '' then
      table.insert(path_list, path)
    end
  end
  return table.concat(path_list, ',')
end
lspconfig.clangd.setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  capabilities = vim.tbl_deep_extend('keep', { offsetEncoding = { 'utf-16', 'utf-8' } }, capabilities),
  single_file_support = true,
  filetypes = { 'cpp', 'c', 'h', 'hpp', 'cuda' },
  cmd = {
    'clangd',
    '--offset-encoding=utf-16',
    '-j=12',
    '--enable-config',
    '--background-index',
    '--pch-storage=memory',
    -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
    '--query-driver=' .. get_binary_path_list { 'clang++', 'clang', 'gcc', 'g++' },
    '--clang-tidy',
    '--all-scopes-completion',
    '--completion-style=detailed',
    '--header-insertion-decorators',
    '--header-insertion=iwyu',
    '--limit-references=3000',
    '--limit-results=350',
  },
  commands = {
    ClangdSwitchSourceHeader = {
      function()
        switch_source_header_splitcmd(0, 'edit')
      end,
      description = 'Open source/header in current buffer',
    },
    ClangdSwitchSourceHeaderVSplit = {
      function()
        switch_source_header_splitcmd(0, 'vsplit')
      end,
      description = 'Open source/header in a new vsplit',
    },
    ClangdSwitchSourceHeaderSplit = {
      function()
        switch_source_header_splitcmd(0, 'split')
      end,
      description = 'Open source/header in a new split',
    },
  },
  -- on_init = require'clangd_nvim'.on_init,
  -- callbacks = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
  },
  -- settings = require("lsp.servers.clangd").settings,
}

for _, server in ipairs {
  'bashls',
  'yamlls',
  'jsonls',
  'gopls',
  'cssls',
  -- 'marksman',
  'emmet_ls',
  'graphql',
  'html',
  'prismals',
  'pyright',
} do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }
end
