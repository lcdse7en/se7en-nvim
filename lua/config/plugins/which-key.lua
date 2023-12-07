return {
  'folke/which-key.nvim',
  enabled = true,
  keys = { '<leader>', '[', ']', 's' },
  dependencies = { 'wansmer/langmapper.nvim' },
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local lmu = require('langmapper.utils')
    local view = require('which-key.view')
    local execute = view.execute

    -- wrap `execute()` and translate sequence back
    view.execute = function(prefix_i, mode, buf)
      -- translate back to english characters
      prefix_i = lmu.translate_keycode(prefix_i, 'default', 'ru')
      execute(prefix_i, mode, buf)
    end

    -- if you want to see translated operators, text objects and motions in
    -- which-key prompt
    -- local presets = require('which-key.plugins.presets')
    -- presets.operators = lmu.trans_dict(presets.operators)
    -- presets.objects = lmu.trans_dict(presets.objects)
    -- presets.motions = lmu.trans_dict(presets.motions)
    -- etc

    local wk = require('which-key')
    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false, -- adds help for motions text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
      },
      window = {
        border = 'rounded', -- none, single, double, shadow, rounded
        position = 'bottom',
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
        align = 'left', -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      -- triggers = "auto", -- automatically setup triggers
      triggers = { '<leader>' }, -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    })

    local opts = {
      mode = 'n', -- NORMAL mode
      prefix = '<leader>',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local visual_opts = {
      mode = 'v', -- NORMAL mode
      prefix = '<leader>',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local normal_mode_mappings = {
      -- single
      ['='] = { '<cmd>vertical resize +5<CR>', 'resize +5' },
      ['-'] = { '<cmd>vertical resize -5<CR>', 'resize +5' },
      ['v'] = { '<C-W>v', 'split right' },
      ['V'] = { '<C-W>s', 'split below' },

      a = {
        name = 'Set Number | [A]lternate true | false',
        n = { '<cmd>set nonumber!<CR>', 'line numbers' },
        r = { '<cmd>set norelativenumber!<CR>', 'relative number' },
      },
      f = {
        name = 'Find Files',
      },
      o = {
        name = 'Terminal Float | URL',
      },
      s = {
        name = 'spectre',
      },
      w = {
        name = 'Window Picker',
      },
    }

    wk.register(normal_mode_mappings, opts)
    wk.register(visual_mode_mappings, visual_opts)
  end,
}
