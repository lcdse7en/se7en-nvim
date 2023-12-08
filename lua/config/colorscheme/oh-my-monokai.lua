--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 04:28:09         *
-- Description :                             *
--********************************************


require("oh-my-monokai").setup({
  transparent_background = false,
  terminal_colors = true,
  devicons = true, -- highlight the icons of `nvim-web-devicons`
  palette = "default", -- or create your own ^^ e.g. justinsgithub
  inc_search = "background", -- underline | background
  background_clear = {
    -- "float_win",
    "toggleterm",
    "telescope",
    "which-key",
    "renamer"
  },-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree"
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
    },
    indent_blankline = {
      context_start_underline = false,
    },
  },
  ---@param c Colorscheme
  override = function(c) end,
})
