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
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
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

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open Lazy' })
