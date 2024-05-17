return {
  'echasnovski/mini.files',
  enabled = true,
  config = function()
    require('mini.files').setup {
      mappings = {
        close = 'q',
        go_in = '<Right>',
        go_in_plus = '<A-Right>',
        go_out = '<Left>',
        go_out_plus = '<A-Left>',
        reveal_cwd = '<A-Up>',
      },
      windows = {
        preview = true,
      },
    }
  end
}
