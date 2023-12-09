--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-09 19:21:07         *
-- Description :                             *
--********************************************

return {
  'toppair/peek.nvim',
  enabled = false,
  keys = {
    {
      '<leader>cp',
      ft = 'markdown',
      function()
        local peek = require 'peek'
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end,
      {
        desc = 'Peek (Markdown Preview)',
        silent = true,
      },
    },
  },
  config = function()
    local peek = require 'peek'
    peek.setup {
      auto_load = true, -- whether to automatically load preview when
      -- entering another markdown buffer
      close_on_bdelete = true, -- close preview window on buffer delete

      syntax = true, -- enable syntax highlighting, affects performance

      theme = 'light', -- 'dark' or 'light'

      update_on_change = true,

      app = { 'chromium', '--new-window' }, -- 'webview', 'browser', string or a table of strings

      filetype = { 'markdown' }, -- list of filetypes to recognize as markdown

      -- relevant if update_on_change is true
      throttle_at = 200000, -- start throttling when file exceeds this
      -- amount of bytes in size
      throttle_time = 'auto', -- minimum amount of time in milliseconds
      -- that has to pass before starting new render
    }
  end,
}
