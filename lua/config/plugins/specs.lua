return {
  'edluffy/specs.nvim',
  keys = { { 'n', 'N' }, mode = { 'v' } },
  enabled = false,
  config = function()
    require('specs').setup {
      show_jumps = true,
      min_jump = 30,
      popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 10, -- time increments used for fade/resize effects
        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 20,
        winhl = 'PMenu',
        fader = require('specs').linear_fader,
        resizer = require('specs').shrink_resizer,
      },
      ignore_filetypes = {},
      ignore_buftypes = {
        nofile = true,
      },
    }

    -- center and highlight results
    vim.keymap.set('n', 'n', 'nzz:lua require("specs").show_specs()<CR>', { silent = true })
    vim.keymap.set('n', 'N', 'Nzz:lua require("specs").show_specs()<CR>', { silent = true })
  end,
}
