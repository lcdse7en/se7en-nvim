return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local exclude_ft = {
      'help',
      'git',
      'markdown',
      'snippets',
      'text',
      'gitconfig',
      'alpha',
      'dashboard',
      'sh',
      'TelescopePrompt',
      'Float',
    }
    require('ibl').setup {
      indent = {
        char = '│',
      },
      scope = {
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = exclude_ft,
        buftypes = { 'terminal' },
      },
    }

    local gid = vim.api.nvim_create_augroup('indent_blankline', { clear = true })
    vim.api.nvim_create_autocmd('InsertEnter', {
      pattern = '*',
      group = gid,
      command = 'IBLDisable',
    })

    vim.api.nvim_create_autocmd('InsertLeave', {
      pattern = '*',
      group = gid,
      callback = function()
        if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
          vim.cmd [[IBLEnable]]
        end
      end,
    })
  end,
}
