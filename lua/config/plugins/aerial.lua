--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-15 03:04:56         *
-- Description :                             *
--********************************************

return {
  'stevearc/aerial.nvim',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>at', '<cmd>AerialToggle<CR>', desc = 'AerialToggle' },
    { '<leader>fa', '<cmd>Telescope aerial<cr>', desc = 'Telescope Aerial' },
  },
  config = function()
    local aerial = require 'aerial'
    aerial.setup {
      backends = { 'treesitter', 'lsp', 'markdown', 'man' },
      layout = {
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 30,
        win_opts = {},
        default_direction = 'prefer_left',
        placement = 'window',
        preserve_equality = false,
      },
      attach_mode = 'window',
      lazy_load = true,
      disable_max_lines = 10000,
      disable_max_size = 2000000,

      -- A list of all symbols to display. Set to false to display all symbols.
      -- To see all available values, see :help SymbolKiind

      filter_kind = false,
      -- filter_kind = {
      --   "Class",
      --   "Constructor",
      --   "Enum",
      --   "Function",
      --   "Interface",
      --   "Module",
      --   "Method",
      --   "Struct",
      -- },

      highlight_mode = 'split_width',
      highlight_on_hover = false, -- Highlight the symbol in the source buffer when cursor is in the  aerial win
      highlight_on_jump = 300,
      autojump = false, -- Jump to symbol in source window when the cursor moves
      nerd_font = 'auto',
      post_jump_cmd = 'normal! zz',
      post_parse_symbol = function(bufnr, item, ctx)
        return true
      end,
      post_add_all_symbols = function(bufnr, items, ctx)
        return items
      end,
      close_on_select = false, -- When true, aerial will automatically close after jumping to a symbol
      update_events = 'TextChanged,InsertLeave',
      show_guides = false,
      float = {
        border = 'rounded',
        relative = 'cursor',
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },
      },
      lsp = {
        diagnostics_trigger_update = true,
        update_when_errors = true,
        update_delay = 300,
        priority = {
          -- pyright = 10,
        },
      },
      treesitter = {
        -- How long to wait (in ms) after a buffer change before updating
        update_delay = 300,
      },
      markdown = {
        -- How long to wait (in ms) after a buffer change before updating
        update_delay = 300,
      },
      man = {
        -- How long to wait (in ms) after a buffer change before updating
        update_delay = 300,
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<leader>fa', '<cmd>Telescope aerial<CR>', { silent = true })
      end,
    }
  end,
}
