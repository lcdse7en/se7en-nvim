return {
  'nvim-pack/nvim-spectre', --  NOTE: <leader>R : confirm all
  lazy = true,
  keys = {
    {
      '<Leader>sf',
      "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
      desc = '󰛔 Spectre search current file',
    },
    {
      '<Leader>so',
      "<cmd>lua require('spectre').open()<CR>",
      desc = '󰛔 Open Spectre',
    },
    {
      '<Leader>sw',
      "<cmd>lua require('spectre').open_visual({select_word})<CR>",
      desc = '󰛔 Spectre search current word',
    },
  },
}
