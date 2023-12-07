return {
  'williamboman/mason.nvim',
  enabled = true,
  event = 'UIEnter',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  cmd = { 'Mason', 'MasonInstall', 'MasonUnistall', 'MasonUpdate' },
  keys = {
    { '<leader>fm', '<cmd>Mason<cr>', desc = 'Mason' },
  },
  config = function()
    require('mason').setup({
      ui = {
        border = PREF.ui.border,
      },
    })
  end,
}
