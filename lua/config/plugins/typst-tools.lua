return {
  'max397574/typst-tools.nvim',
  ft = {
    'typst',
  },
  enabled = true,
  config = function()
    require('typst-tools').setup()
  end,
}
