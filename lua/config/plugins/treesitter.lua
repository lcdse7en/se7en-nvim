return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  build = function()
    require('nvim-treesitter.install').update { with_sync = true }
  end,
  dependencies = {
    { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
  },
  lazy = true,
  event = { 'BufReadPre' },
  -- init = function()
  --   vim.keymap.set('n', 'tsp', '<Cmd>TSPlaygroundToggle<Cr>')
  --   vim.keymap.set('n', 'tsn', '<Cmd>TSNodeUnderCursor<Cr>')
  --   vim.keymap.set('n', 'tsh', '<Cmd>TSHighlightCapturesUnderCursor<Cr>')
  -- end,
  config = function()
    local configs = require 'nvim-treesitter.configs'
    configs.setup {
      -- ensure_installed = 'all',

      ensure_installed = {
        'lua',
        'nix',
        'bash',
        'c',
        'cpp',
        'cmake',
        'typst',
        'http',
        'sql',
        'php',
        'python',
        'rust',
        'go',
        'fish',
        'gitignore',
        'toml',
        'yaml',
        'zig',
        'tsx',
        'typescript',
        'javascript',
        'html',
        'css',
        'scss',
        'vue',
        'astro',
        'svelte',
        'gitcommit',
        'graphql',
        'json',
        'json5',
        'markdown',
        'prisma',
        'vim',
        'csv',
        'diff',
      },

      sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { 'haskell', 'phpdoc', 'comment' },
      highlight = {
        enable = true,
        -- disable = {},
        -- additional_vim_regex_highlighting = false,
        additional_vim_regex_highlighting = { 'org' },
      },

      -- https://githubfast.com/nvim-treesitter/playground#query-linter
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { 'BufWrite', 'CursorHold' },
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },

      -- WARNING: Делает лишний отступ во Vue
      indent = {
        enable = true,
      },

      incremental_selection = {
        -- using `flash.nvim`
        enable = false,
        keymaps = {
          -- set to `false` to disable one of the mappings
          init_selection = '<CR>',
          node_incremental = '<CR>',
          node_decremental = '<BS>',
          scope_incremental = false,
        },
      },

      autotag = { enable = true }, -- windwp/nvim-ts-autotag
      -- TREESITTER PLUGINS
      autopairs = {
        enable = true,
      },
    }

    -- MDX
    vim.filetype.add {
      extension = {
        mdx = 'mdx',
      },
    }
    vim.treesitter.language.register('markdown', 'mdx')
  end,
}
