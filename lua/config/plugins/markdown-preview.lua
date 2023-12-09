--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-09 19:28:13         *
-- Description :                             *
--********************************************

return {
  'iamcco/markdown-preview.nvim',
  enabled = true,
  build = 'cd app && npm install',
  setup = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
}
