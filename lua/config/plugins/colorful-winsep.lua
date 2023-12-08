--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 22:31:39         *
-- Description :                             *
--********************************************

return {
  'nvim-zh/colorful-winsep.nvim',
  enabled = true,
  lazy = true,
  event = 'WinNew',
  config = function()
    local colorful_winsep = require 'colorful-winsep'
    colorful_winsep.setup()
  end,
}
