return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  cmd = 'Telescope',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'cljoly/telescope-repo.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-live-grep-raw.nvim' },
    { 'MattesGroeger/vim-bookmarks' },
    { 'tom-anders/telescope-vim-bookmarks.nvim' },
    {
      'debugloop/telescope-undo.nvim',
    },
    { 'nvim-telescope/telescope-frecency.nvim', dependencies = { 'kkharji/sqlite.lua' } },
    {
      'crispgm/telescope-heading.nvim',
      lazy = true,
      ft = { 'markdown', 'org' },
    },
    { 'jvgrootveld/telescope-zoxide' }, --  NOTE: sudo pacman -S zoxide | zoxide add path
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-media-files.nvim' },
  },
  config = function()
    local telescope = require('telescope')
    local pickers = require('telescope.builtin')

    --  NOTE: Custom pickers
    function edit_neovim()
      pickers.git_files(require('telescope.themes').get_dropdown({
        color_devicons = true,
        cwd = '~/.config/nvim',
        previewer = false,
        prompt_title = 'Se7enNvim Dotfiles',
        sorting_strategy = 'ascending',
        winblend = 4,
        layout_config = {
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
          },
          prompt_position = 'top',
        },
      }))
    end

    local map = vim.keymap.set
    -- Builtins pickers
    map('n', '<leader>fb', '<cmd>silent BrowseBookmarks<cr>', { desc = 'Browse Bookmarks' })
    map('n', '<leader>fc', pickers.find_files, { desc = 'Telescope: Find files in (cwd>' })
    map('n', '<leader>ff', '<cmd>lua edit_neovim()<cr>', { desc = 'Nvim Dotfiles' })
    map('n', '<leader>fg', pickers.live_grep, { desc = 'Telescope: live grep (cwd>' })
    map('n', '<localleader>b', pickers.buffers, { desc = 'Telescope: show open buffers' })
    -- map('n', '<localleader>d', pickers.diagnostics, { desc = 'Telescope: show diagnostics' })
    map('n', '<leader>fo', pickers.oldfiles, { desc = 'Telescope: show recent using files' })
    map('n', '<localleader><localleader>', function()
      pickers.current_buffer_fuzzy_find({ default_text = vim.fn.expand('<cword>') })
    end, { desc = 'Telescope: fuzzy find word under cursor in current buffer' })
    map('n', '<localleader>s', function()
      pickers.live_grep({ default_text = vim.fn.expand('<cword>') })
    end, { desc = 'Telescope: live grep word under cursor (cwd>' })
    map('n', '<localleader>p', function()
      pickers.find_files({ default_text = vim.fn.expand('<cword>') })
    end, { desc = 'Telescope: find file under cursor (cwd)' })
    map('n', '<localleader>T', function()
      pickers.builtin({ include_extensions = true })
    end)

    -- Plugin's pickers
    map('n', '<localleader>n', ':Telescope notify<CR>', { desc = 'Telescope: show notifications' })

    -- WARNING: now works only with 'cwd' pickers, because no need know bufnr
    local switch_picker = function(picker_name)
      return function(prompt_bufnr)
        local cur_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        local text = cur_picker:_get_prompt()
        pickers[picker_name]({
          default_text = text,
        })
      end
    end

    local actions = require('telescope.actions')
    telescope.setup({
      defaults = {
        history = {
          path = vim.fn.stdpath('data') .. '/databases/telescope_history.sqlite3',
          limit = 200,
        },
        border = true,
        hl_result_eol = true,
        multi_icon = '',
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        -- layout_config = { prompt_position = 'bottom' },
        layout_config = {
          horizontal = {
            preview_cutoff = 120,
          },
          prompt_position = 'top',
        },
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' ',
        selection_caret = ' ',
        path_display = { 'smart' },
        layout_strategy = 'horizontal',
        file_ignore_patterns = { '.git/', 'node_modules/*' },
        sorting_strategy = 'ascending',
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        mappings = {
          i = {
            ['<ESC>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-2>'] = switch_picker('live_grep'),
            ['<C-3>'] = switch_picker('find_files'),
            ['<C-g>'] = actions.select_horizontal,
            ['<C-u>'] = false, -- Clear instead of preview scroll up
            ['<S-Cr>'] = function(prompt_bufnr)
              -- Use nvim-window-picker to choose the window by dynamically attaching a function
              local action_set = require('telescope.actions.set')
              local action_state = require('telescope.actions.state')

              local cur_picker = action_state.get_current_picker(prompt_bufnr)
              cur_picker.get_selection_window = function(picker, _)
                local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
                -- Unbind after using so next instance of the picker acts normally
                picker.get_selection_window = nil
                return picked_window_id
              end

              return action_set.edit(prompt_bufnr, 'edit')
            end,
          },
        },
      },
      extensions = {
        bookmarks = { selected_browser = 'chrome' }, -- edge firefox safari brave
      },
    })
  end,
}
