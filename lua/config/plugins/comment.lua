return {
  'numToStr/Comment.nvim',
  enabled = true,
  event = { 'BufReadPre' },
  keys = {
    {
      '<leader>cc',
      '<cmd>lua require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>',
      mode = { 'n' },
      desc = 'Toggle comment line',
    },
    {
      '<leader>cc',
      '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>',
      mode = { 'v' },
      desc = 'Toggle comment for selection',
    },
  },
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
  },
  config = function()
    -- to skip backwards compatibility routines and speed up loading
    vim.g.skip_ts_context_commentstring_module = true
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end,
}
