return {
  'mbbill/undotree',
  lazy = false, -- needs to be explicitly set, because of the keys property
  keys = {
    {
      '<leader>od',
      vim.cmd.UndotreeToggle,
      desc = 'Toggle undotree',
    },
  },
}
