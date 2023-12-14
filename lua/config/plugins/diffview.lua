--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-15 02:46:20         *
-- Description :                             *
--********************************************

return {
  'sindrets/diffview.nvim',
  enabled = true,
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewFocusFiles',
    'DiffviewFileHistory',
    'DiffviewToggleFiles',
    'DiffviewRefresh',
  },
  event = 'BufRead',
  keys = {
    { '<Leader>df', "<cmd>lua require('utils.git').toggle_file_history()<CR>", desc = 'diff file' },
    {
      '<Leader>dt',
      "<cmd>lua require('utils.git').toggle_status()<CR>",
      desc = 'diffview status Toggle',
    },
    { '<Leader>do', '<cmd>DiffviewOpen<CR>', desc = 'diffviewopen' },
    { '<Leader>dc', '<cmd>DiffviewClose<CR>', desc = 'diffviewclose' },
    { '<Leader>dr', '<cmd>DiffviewRefresh<CR>', desc = 'DiffviewRefresh' },
  },
  config = function()
    local diffview = require 'diffview'
    diffview.setup {}
  end,
}
