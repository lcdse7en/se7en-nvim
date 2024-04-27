--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2024-04-27 19:32:38         *
-- Description :                             *
--********************************************

return {
  'xiyaowong/transparent.nvim',
  cmd = { 'TransparentEnable', 'TransparentDisable', 'TransparentToggle' },
  enabled = function()
    return vim.env.TERM_PROGRAM == 'WezTerm'
  end,
  config = function()
    local transparen = require 'transparen'
    transparen.setup()
    vim.cmd 'TransparentEnable'
  end,
}
