--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 16:13:07         *
-- Description :                             *
--********************************************

return {
  "windwp/nvim-ts-autotag",
  enabled = true,
  event = "InsertEnter",
  ft = { 'html', 'javascript', 'typescript', 'typescriptreact' },
  config = true,
}
