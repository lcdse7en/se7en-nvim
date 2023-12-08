return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    local picker = require 'window-picker'
    picker.setup {
      -- 'statusline-winbar' | 'floating-big-letter'
      -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
      -- 'floating-big-letter' draw big letter on a floating window
      -- used
      hint = 'statusline-winbar',
      -- hint = "floating-big-letter",

      -- when you go to window selection mode, status bar will show one of
      -- following letters on them so you can use that letter to select the window
      selection_chars = 'FJDKSLA;CMRUEIWOQP',

      -- This section contains picker specific configurations
      picker_config = {
        statusline_winbar_picker = {
          selection_display = function(char, windowid)
            return '%=' .. char .. '%='
          end,

          -- whether you want to use winbar instead of the statusline
          -- "always" means to always use winbar,
          -- "never" means to never use winbar
          -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
          use_winbar = 'never', -- "always" | "never" | "smart"
        },

        floating_big_letter = {
          font = 'ansi-shadow', -- ansi-shadow |
        },
      },

      -- whether to show 'Pick window:' prompt
      show_prompt = true,

      -- prompt message to show to get the user input
      prompt_message = 'Please select Pick window: ',

      filter_func = nil,

      filter_rules = {
        autoselect_one = true,
        include_current_win = true,
        bo = {
          filetype = { 'notify' },
          buftype = { 'terminal' },
        },

        -- filter using window options
        wo = {},

        -- if the file path contains one of following names, the window
        -- will be ignored
        file_path_contains = {},

        -- if the file name contains one of following names, the window will be
        -- ignored
        file_name_contains = {},
      },

      -- You can pass in the highlight name or a table of content to set as
      -- highlight
      highlights = {
        statusline = {
          focused = {
            fg = '#ededed',
            bg = '#e35e4f',
            bold = true,
          },
          unfocused = {
            fg = '#ededed',
            bg = '#44cc41',
            bold = true,
          },
        },
        winbar = {
          focused = {
            fg = '#ededed',
            bg = '#e35e4f',
            bold = true,
          },
          unfocused = {
            fg = '#ededed',
            bg = '#44cc41',
            bold = true,
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>wp', function()
      local window_number = require('window-picker').pick_window()
      if window_number then
        vim.api.nvim_set_current_win(window_number)
      end
    end, { silent = true, desc = '[P]icker [W]indow' })

    -- Swap two windows using the awesome window picker
    local function swap_windows()
      local window = picker.pick_window {
        include_current_win = false,
      }
      local target_buffer = vim.fn.winbufnr(window)
      -- Set the target window to contain current buffer
      vim.api.nvim_win_set_buf(window, 0)
      -- Set current window to contain target buffer
      vim.api.nvim_win_set_buf(0, target_buffer)
    end

    vim.keymap.set('n', '<leader>ws', swap_windows, { desc = 'Swap windows' })
  end,
}
