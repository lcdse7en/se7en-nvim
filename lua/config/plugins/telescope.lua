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
    { 'jvgrootveld/telescope-zoxide' }, --  NOTE: sudo pacman -S zoxide | zoxide add path
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
    local telescope = require('telescope')
    local pickers = require('telescope.builtin')
    local actions = require "telescope.actions"
    local fb_actions = require("telescope").extensions.file_browser.actions
    local lga_actions = require "telescope-live-grep-args.actions"

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

    function project_files(opts)
      opts = opts or {} -- define here if you want to define something
      local ok = pcall(require("telescope.builtin").git_files, opts)
      if not ok then
        require("telescope.builtin").find_files(opts)
      end
    end

    local map = vim.keymap.set
    -- Builtins pickers
    map('n', '<leader>fb', '<cmd>silent BrowseBookmarks<cr>', { desc = 'Browse Bookmarks' })
    map('n', '<leader>fB', pickers.buffers, { desc = 'Telescope: show open buffers' })
    map('n', '<leader>fc', pickers.find_files, { desc = 'Telescope: Find files in (cwd>' })
    map('n', '<leader>fd', pickers.diagnostics, { desc = 'Telescope: show diagnostics' })
    map('n', '<leader>ff', '<cmd>lua edit_neovim()<cr>', { desc = 'Nvim Dotfiles' })
    map('n', '<leader>fg', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', { desc = 'Find Text' })
    map('n', '<leader>fG', pickers.live_grep, { desc = 'Telescope: live grep (cwd>' })
    map('n', '<leader>fi', '<cmd>silent BrowseInputSearch<cr>', { desc = 'BrowseInputSearch' })
    map('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', { desc = 'Telescope: Find keymaps' })
    map('n', '<leader>fo', pickers.oldfiles, { desc = 'Open Recent Files' })
    map('n', '<leader>fO',
        function()
          local function telescope_buffer_dir()
            return vim.fn.expand "%:p:h"
          end

          telescope.extensions.file_browser.file_browser {
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          }
        end,
    { desc = 'Open File Browser with the path of the current buffer' })
    map('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'TodoTelescope: Search Todo Comments' })
    map('n', '<leader>fn', '<cmd>Telescope notify<CR>', { desc = 'Telescope: show notifications' })
    map('n', '<leader>fh', 'Telescope yank_history<cr>', { desc = 'Telescope: search yank_history' })
    map('n', '<leader>fp', '<cmd>lua require("plugins.telescope").project_files()<cr>', { desc = 'Project Files' })
    map('n', '<leader>fv',         function()
          local builtin = require "telescope.builtin"
          builtin.treesitter()
        end,
    { desc = 'Lists FunctionNames | variables from Treesitter' })

    map('n', '<leader>ot', '<cmd>silent ToggleTerm direction=float<CR>', { desc = 'Terminal Float' })


    --  WARNING: now works only with 'cwd' pickers, because no need know bufnr
    local switch_picker = function(picker_name)
      return function(prompt_bufnr)
        local cur_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
        local text = cur_picker:_get_prompt()
        pickers[picker_name]({
          default_text = text,
        })
      end
    end

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
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            ["n"] = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd "startinsert"
              end,
              ["<C-k>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-j"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp"] = actions.preview_scrolling_up,
              ["<PageDown"] = actions.preview_scrolling_down,
            },
          },
        },
        frecency = {
          ignore_patterns = {
            "*.git/*",
            "*/tmp/*",
            "/home/se7en/dotfiles/*",
          },
          show_scores = true,
          show_unindexed = true,
          workspaces = {
            ["dotfiles"] = "/home/se7en/.config/",
            ["projects"] = "/home/se7en/PyProject/",
          },
          prompt_title = "Find Files",
          preview_title = "Preview",
          results_title = "Files",
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["C-k"] = lga_actions.quote_prompt(),
              ["C-i"] = lga_actions.quote_prompt { postfix = " --iglob" },
            },
          },
        },
        undo = {
          use_delta = true,
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.4,
          },
          mappings = {
            i = {
              ["<cr>"] = require("telescope-undo.actions").yank_additions,
              ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
              ["<C-cr>"] = require("telescope-undo.actions").restore,
            },
          },
          results_title = "Undo History",
          prompt_title = "Search",
          preview_title = "Edit Diff",
        },
      },
    })

    --  NOTE: Load Extensions
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "repo"
    require("telescope").load_extension "zoxide"
    require("telescope").load_extension "file_browser"
    -- require("telescope").load_extension "projects"
    require("telescope").load_extension "git_worktree"
    require("telescope").load_extension "vim_bookmarks" -- mm | <leader>a
    -- require("telescope").load_extension "frecency"
    require("telescope").load_extension "live_grep_args"
    require("telescope").load_extension "undo"
  end,
}
