--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2024-01-06 13:46:58         *
-- Description :                             *
--********************************************

return {
  'simrat39/rust-tools.nvim',
  enabled = true,
  event = 'BufReadPre Cargo.toml,*.rs',
  config = function()
    local rust_tools = require 'rust-tools'
    local opts = {
      tools = {
        executor = require('rust-tools/executors').termopen,
        -- These apply to the default RustSetInlayHints command
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
          parameter_hints_prefix = '<- ',
          other_hints_prefix = '=> ',
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
        },
        hover_actions = {
          auto_focus = true,
        },
      },
      -- send our rust-analyzer configuration to lspconfig
      server = {
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              autoreload = true,
            },
            checkOnSave = {
              command = 'clippy',
            },
            inlayHints = {
              bindingModeHints = { enable = true },
              closureReturnTypeHints = { enable = true },
              lifetimeElisionHints = { enable = true },
              reborrowHints = { enable = true },
            },
            diagnostics = {
              disabled = { 'inactive-code', 'unresolved-proc-macro' },
            },
            procMacro = { enable = true },
            files = {
              excludeDirs = {
                '.direnv',
                'target',
                'js',
                'node_modules',
                'assets',
                'ci',
                'data',
                'docs',
                'store-metadata',
                '.gitlab',
                '.vscode',
                '.git',
              },
            },
            completion = {
              postfix = {
                enable = false,
              },
            },
          },
        },
        -- on_attach = on_lsp_attach,
      }, -- rust-analyer options
    }
    rust_tools.setup(opts)
  end,
}
