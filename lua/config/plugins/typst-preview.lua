--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-17 23:48:03         *
-- Description :                             *
--********************************************

return {
  'chomosuke/typst-preview.nvim',
  enabled = true,
  ft = 'typst',
  version = '0.1.*',
  build = function()
    require('typst-preview').update()
  end,
  config = function()
    local tp = require 'typst-preview'
    local wk = require 'which-key'
    wk.register({
      ['<leader>o'] = {
        name = 'typst-preview',
        s = { tp.sync_with_cursor, 'Scroll preview' },
        t = {
          function()
            tp.set_follow_cursor(not tp.get_follow_cursor())
          end,
          'Toggle preview scroll mode',
        },
      },
    }, { mode = 'n' })
    require('typst-preview').setup { debug = true }
  end,
}
