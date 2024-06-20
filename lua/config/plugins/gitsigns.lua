return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  enabled = true,
  config = function()
    local map = vim.keymap.set
    map('n', '<Leader>gp', ':Gitsigns prev_hunk<CR>', { desc = 'Plug Gitsigns: jump to prev hunk' })
    map('n', '<Leader>gn', ':Gitsigns next_hunk<CR>', { desc = 'Plug Gitsigns: jump to next hunk' })
    map('n', '<Leader>gs', ':Gitsigns preview_hunk<CR>', { desc = 'Plug Gitsigns: preview hunk' })
    map('n', '<Leader>gd', ':Gitsigns diffthis<CR>', { desc = 'Plug Gitsigns: open diffmode' })
    map('n', '<Leader>ga', ':Gitsigns stage_hunk<CR>', { desc = 'Plug Gitsigns: stage current hunk' })
    map('n', '<Leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Plug Gitsigns: reset current hunk' })
    map('n', '<Leader>gA', ':Gitsigns stage_buffer<CR>', { desc = 'Plug Gitsigns: stage current buffer' })
    map('n', '<Leader>gR', ':Gitsigns reset_buffer<CR>', { desc = 'Plug Gitsigns: reset current buffer' })

    require('gitsigns').setup {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
    }
  end,
}
