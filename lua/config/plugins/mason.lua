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
    { '<leader>om', '<cmd>Mason<cr>', desc = 'Mason' },
  },
  config = function()
    require('mason').setup({
      ui = {
        border = "rounded",
      },
    })
  end,
}
