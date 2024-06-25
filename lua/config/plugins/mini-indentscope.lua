--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2024-04-27 20:32:31         *
-- Description :                             *
--********************************************

return {
  'echasnovski/mini.indentscope',
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = 'VeryLazy',
  opts = {
    -- symbol = "▏",
    symbol = '│',
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'trouble',
        'lazy',
        'noice',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
        'better_term',
        'checkhealth',
        'csv',
        'crunner',
        'lspinfo',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
