return {
  'winter-again/wezterm-config.nvim',
  config = function()
    require('wezterm_config').setup {
      append_wezterm_to_rtp = true,
    }
  end,
}
