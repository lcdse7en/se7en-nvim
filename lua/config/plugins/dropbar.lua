return {
  'Bekaboo/dropbar.nvim',
  enabled = false,
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  config = function()
    require('dropbar').setup()
  end,
}
