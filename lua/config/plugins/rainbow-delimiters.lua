--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-25 09:13:05         *
-- Description :                             *
--********************************************

return {
  'HiPhish/rainbow-delimiters.nvim',
  enabled = false,
  event = 'BufEnter',
  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'

    vim.g.rainbow_delimiters = {
      -- strategy = {
      --   [""] = rainbow_delimiters.strategy["global"],
      --   vim = rainbow_delimiters.strategy["local"],
      -- },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-parens',
        typescript = 'rainbow-parens',
        javascript = 'rainbow-parens',
        typescriptreact = 'rainbow-parens',
        javascriptreact = 'rainbow-parens',
        tsx = 'rainbow-parens',
        jsx = 'rainbow-parens',
        html = 'rainbow-parens',
      },
      highlight = {

        -- "TSRainbowRed",
        'TSRainbowBlue',
        -- "TSRainbowOrange",
        -- "TSRainbowCoral",
        -- "TSRainbowPink",
        'TSRainbowViolet',
        'TSRainbowYellow',
        -- "TSRainbowGreen",

        -- TODO: define these in colorscheme
        -- "RainbowDelimiterRed",
        -- "RainbowDelimiterYellow",
        -- "RainbowDelimiterBlue",
        -- "RainbowDelimiterOrange",
        -- "RainbowDelimiterGreen",
        -- "RainbowDelimiterViolet",
        -- "RainbowDelimiterCyan",
      },
    }
  end,
}
