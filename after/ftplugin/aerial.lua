--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2024-01-06 13:37:14         *
-- Description :                             *
--********************************************

local api = vim.api
local winid = vim.api.nvim_get_current_win()
vim.b.minicursorword_disable = true
vim.b.stl_foldlevel = false
vim.wo.number = true
vim.wo.relativenumber = true

api.nvim_set_option_value('spell', false, {
  win = winid,
})
api.nvim_set_option_value('foldcolumn', '0', {
  win = winid,
})
