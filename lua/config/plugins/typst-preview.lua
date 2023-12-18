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
}
