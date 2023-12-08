--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 19:42:19         *
-- Description :                             *
--********************************************

return {
  'lmburns/lf.nvim',
  enabled = true,
  cmd = 'Lf',
  keys = {
    {
      '<leader>Lf',
      "<cmd>lua require('lf').start({highlights = {FloatBorder = {guifg = '#819c3B'}}})<cr>",
      desc = 'lf',
    },
  },
  dependencies = {
    'akinsho/nvim-toggleterm.lua',
  },
  config = function()
    local lf = require 'lf'
    lf.setup {
      winblend = 10,
      escape_quit = true,
      focus_on_open = true,
      border = 'rounded',
      mappings = true,
      height = nil,
      width = nil,
      tmux = false,
      highlights = {
        Normal = { link = 'Normal' },
        NormalFloat = { link = 'Normal' },
      },
    }

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'LfTermEnter',
      callback = function(a)
        vim.api.nvim_buf_set_keymap(a.buf, 't', 'q', 'q', { nowait = true })
      end,
    })
  end,
}
