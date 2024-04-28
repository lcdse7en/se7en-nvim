return {
  'lukas-reineke/indent-blankline.nvim',
  enabled = true,
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local exclude_ft = {
      'startify',
      'dashboard',
      'dotooagenda',
      'log',
      'fugitive',
      'gitcommit',
      'packer',
      'vimwiki',
      'markdown',
      'json',
      'txt',
      'vista',
      'help',
      'todoist',
      'NvimTree',
      'neo-tree',
      'peekaboo',
      'git',
      'TelescopePrompt',
      'undotree',
      'flutterToolsOutline',
      '', -- for all buffers without a file type
    }
    require('ibl').setup {
      debounce = 200,
      indent = {
        -- char = '│',
        char = { '|', '¦', '┆', '┊' },
        -- tab_char = nil,
        tab_char = '│',
        highlight = 'IblIndent',
        smart_indent_cap = true,
        priority = 1,
      },
      whitespace = {
        highlight = 'IblWhitespace',
        remove_blankline_trail = true,
      },
      scope = {
        enabled = false,
        char = '▏',
        -- char = '│',
        show_start = true,
        show_end = true,
        show_exact_scope = true,
        injected_languages = true,
        highlight = 'IblScope',
        priority = 1024,
        include = {
          node_type = { lua = { 'return_statement', 'table_constructor' } },
        },
        exclude = {
          language = {},
          node_type = {
            ['*'] = { 'source_file', 'program' },
            lua = { 'chunk' },
            python = { 'module' },
          },
        },
      },
      exclude = {
        filetypes = exclude_ft,
        buftypes = { 'terminal', 'nofile', 'quickfix', 'prompt' },
      },
    }

    local gid = vim.api.nvim_create_augroup('indent_blankline', { clear = true })
    -- vim.api.nvim_create_autocmd('InsertEnter', {
    --   pattern = '*',
    --   group = gid,
    --   command = 'IBLDisable',
    -- })

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
