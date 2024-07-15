local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
local configs = 'config.plugins'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup(configs, {
  lockfile = '~/.config/nvim/lazy-lock.json',
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { PREF.ui.colorscheme },
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  concurrency = 5,
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
    debug = false,
    ui = {
      icons = {
        ft = '',
        lazy = '󰂠 ',
        loaded = '',
        not_loaded = '',
      },
      -- border = PREF.ui.border,
      border = 'single',
    },
  },
})

vim.keymap.set('n', '<leader>L', '<cmd>Lazy<cr>', { desc = 'Open Lazy' })
