--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 23:17:18         *
-- Description :                             *
--********************************************

return {
  'ThePrimeagen/harpoon',
  enabled = true,
  lazy = true,
  cmd = 'Telescope harpoon marks',
  keys = {
    { '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = 'Add File' },
    { '<leader>hd', '<cmd>lua require("harpoon.mark").rm_file()<cr>', desc = 'Remove File' },
    { '<leader>hh', '<cmd>Telescope harpoon marks<cr>', desc = 'Telescope: Harpoon' },
    { '<leader>hm', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = 'Toggle Menu' },
    {
      '<leader>hr',
      '<cmd>silent lua require("harpoon.term").sendCommand(1, term.cmds)<cr>',
      desc = 'Term run',
    },
    {
      '<leader>ht',
      '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>',
      desc = 'Open Term',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.g.harpoon_log_level = error
    require('harpoon').setup {
      global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = true,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { 'harpoon' },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,

        -- enable tabline with harpoon marks
        tabline = true,
        tabline_prefix = '  ',
        tabline_suffix = '  ',
      },
      -- ============================================================
      -- Use a dynamic width for the Harpoon popup menu
      -- ============================================================
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      -- ============================================================
      -- To preconfigure terminal commands for later use
      -- ============================================================
      projects = {
        -- Yes $HOME works
        ['$HOME/PyProject/se7en-rye/movies'] = {
          term = {
            cmds = {
              'python3 run.py',
            },
          },
        },
      },
    }

    require('telescope').load_extension 'harpoon'

    vim.cmd 'highlight! HarpoonInactive guibg=NONE guifg=#63698c'
    vim.cmd 'highlight! HarpoonActive guibg=NONE guifg=white'
    vim.cmd 'highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7'
    vim.cmd 'highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7'
    vim.cmd 'highlight! TabLineFill guibg=NONE guifg=white'
  end,
}
