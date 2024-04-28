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
    transparen.setup {
      groups = { -- table: default groups
        'Normal',
        'NormalNC',
        'Comment',
        'Constant',
        'Special',
        'Identifier',
        'Statement',
        'PreProc',
        'Type',
        'Underlined',
        'Todo',
        'String',
        'Function',
        'Conditional',
        'Repeat',
        'Operator',
        'Structure',
        'LineNr',
        'NonText',
        'SignColumn',
        'CursorLine',
        'CursorLineNr',
        'StatusLine',
        'StatusLineNC',
        'EndOfBuffer',
      },
      extra_groups = {
        'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
        'NvimTreeNormal', -- NvimTree
      }, -- table: additional groups that should be cleared
      exclude_groups = {}, -- table: groups you don't want to clear
    }
    transparen.clear_prefix 'NeoTree'

    vim.cmd 'TransparentEnable'
    vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { 'ExtraGroup' })
    vim.g.transparent_groups = vim.list_extend(
      vim.g.transparent_groups or {},
      vim.tbl_map(function(v)
        return v.hl_group
      end, vim.tbl_values(require('bufferline.config').highlights))
    )
  end,
}
