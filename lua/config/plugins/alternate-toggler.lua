return {
  'rmagatti/alternate-toggler', --  NOTE: false | true
  lazy = true,
  cmd = { 'ToggleAlternate' },
  keys = {
    {
      '<leader>aa',
      '<cmd>ToggleAlternate<cr>',
      mode = { 'n' },
      desc = 'Toggle Alternate False  True' ,
    },
  },
}
