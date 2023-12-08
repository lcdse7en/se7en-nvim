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
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('harpoon').setup {}
    require('telescope').load_extension 'harpoon'
  end,
}
