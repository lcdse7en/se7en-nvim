return {
  'folke/which-key.nvim',
  enabled = true,
  keys = { '<leader>', '[', ']', 's' },
  dependencies = { 'wansmer/langmapper.nvim' },
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local lmu = require 'langmapper.utils'
    local view = require 'which-key.view'
    local execute = view.execute

    -- wrap `execute()` and translate sequence back
    view.execute = function(prefix_i, mode, buf)
      -- translate back to english characters
      prefix_i = lmu.translate_keycode(prefix_i, 'default', 'ru')
      execute(prefix_i, mode, buf)
    end

    -- if you want to see translated operators, text objects and motions in
    -- which-key prompt
    -- local presets = require('which-key.plugins.presets')
    -- presets.operators = lmu.trans_dict(presets.operators)
    -- presets.objects = lmu.trans_dict(presets.objects)
    -- presets.motions = lmu.trans_dict(presets.motions)
    -- etc

    local wk = require 'which-key'
    wk.setup {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false, -- adds help for motions text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
      },
      window = {
        border = 'rounded', -- none, single, double, shadow, rounded
        position = 'bottom',
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
        align = 'left', -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      -- triggers = "auto", -- automatically setup triggers
      triggers = { '<leader>' }, -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { 'j', 'k' },
        v = { 'j', 'k' },
      },
    }

    local opts = {
      mode = 'n', -- NORMAL mode
      prefix = '<leader>',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local visual_opts = {
      mode = 'v', -- NORMAL mode
      prefix = '<leader>',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local normal_mode_mappings = {
      -- single
      ['='] = { '<cmd>vertical resize +5<CR>', 'resize +5' },
      ['-'] = { '<cmd>vertical resize -5<CR>', 'resize -5' },
      ['v'] = { '<C-W>v<C-W>w', 'split right' },
      ['V'] = { '<C-W>s<C-W>j', 'split below' },

      a = {
        name = 'Set Number  [A]lternate true  false',
        n = { '<cmd>set nonumber!<CR>', 'line numbers' },
        r = { '<cmd>set norelativenumber!<CR>', 'relative number' },
      },
      c = {
        name = 'LSP  Comment  Format',
      },
      f = {
        name = 'Find Files  Marks',
        e = {
          name = 'Edit NvimConf',
          a = { '<cmd>e ~/.config/nvim/lua/autocmd.lua<CR>', 'Edit autocmds.lua' },
          A = { '<cmd>e ~/.config/nvim/lua/config/plugins/alpha.lua<CR>', 'Edit alpha.lua' },
          b = { '<cmd>e ~/.config/nvim/lua/config/plugins/browse.lua<CR>', 'Edit browse.lua' },
          c = { '<cmd>e ~/.config/nvim/lua/config/plugins/cmp.lua<CR>', 'Edit cmp.lua' },
          C = { '<cmd>e ~/.config/nvim/lua/config/plugins/colorschemes.lua<CR>', 'Edit colorschemes.lua' },
          d = { '<cmd>e ~/.config/nvim/lua/se7en_settings.lua<CR>', 'Edit se7en_settings.lua' },
          f = { '<cmd>e ~/.config/nvim/lua/config/plugins/conform.lua<CR>', 'Edit conform.lua' },
          i = { '<cmd>e $MYVIMRC<CR>', 'Edit init.lua' },
          j = { '<cmd>e ~/.config/nvim/lazy-lock.json<CR>', 'Edit lazy-lock.json' },
          l = { '<cmd>e ~/.config/nvim/lua/lsp/setup.lua<CR>', 'Edit setup.lua(LSP)' },
          m = { '<cmd>e ~/.config/nvim/lua/mappings.lua<CR>', 'Edit mappings.lua' },
          o = { '<cmd>e ~/.config/nvim/lua/options.lua<CR>', 'Edit options.lua' },
          t = { '<cmd>e ~/.config/nvim/lua/config/plugins/telescope.lua<CR>', 'Edit telescope.lua' },
          T = { '<cmd>e ~/.config/nvim/lua/config/plugins/treesitter.lua<CR>', 'Edit treesitter.lua' },
          w = { '<cmd>e ~/.config/nvim/lua/config/plugins/which-key.lua<CR>', 'Edit which-key.lua' },
          --  NOTE: Snippets
          s = {
            name = 'Edit Lua Snippet File',
            a = { '<cmd>e ~/.config/nvim/lua/snippets/all.lua<CR>', 'Edit all.lua(Snippet)' },
            c = { '<cmd>e ~/.config/nvim/lua/snippets/c.lua<CR>', 'Edit c.lua(Snippet)' },
            l = { '<cmd>e ~/.config/nvim/lua/snippets/lua.lua<CR>', 'Edit lua.lua(Snippet)' },
            m = { '<cmd>e ~/.config/nvim/lua/snippets/markdown.lua<CR>', 'Edit markdown.lua(Snippet)' },
            p = { '<cmd>e ~/.config/nvim/lua/snippets/python.lua<CR>', 'Edit python.lua(Snippet)' },
            s = { '<cmd>e ~/.config/nvim/lua/snippets/sh.lua<CR>', 'Edit sh.lua(Snippet)' },
            t = { '<cmd>e ~/.config/nvim/lua/snippets/tex.lua<CR>', 'Edit tex.lua(Snippet)' },
            T = { '<cmd>e ~/.config/nvim/lua/snippets/typst.lua<CR>', 'Edit typst.lua(Snippet)' },
          },
        },
        m = {
          name = 'Telescope: search Marks  Annotation',
          a = { '<cmd>Telescope vim_bookmarks all<cr>', 'Search all bookmarks  Annotation' },
          c = { '<cmd>Telescope vim_bookmarks current_file<cr>', 'Search bookmarks on current file' },
          m = { '<cmd>Telescope marks<cr>', 'Search all marks' },
        },
        u = {
          name = '[U]ndo | [F]recency | [Z]oxide',
          f = { "<cmd> silent lua require('telescope').extensions.frecency.frecency()<CR>", 'Frencency Search' },
          u = { '<cmd>Telescope undo<CR>', 'Undo History' },
          z = { '<cmd> silent Telescope zoxide list<CR>', 'zoxide' },
        },
        z = {
          name = 'edit configfile',
          c = { '<cmd>e ~/.zshrc<cr>', 'edit .zshrc' },
          l = { '<cmd>e ~/.config/lf/lfrc<cr>', 'edit lfrc(lf)' },
          s = { '<cmd>e ~/.config/lf/shortcutrc<cr>', 'edit shortcutrc(lf)' },
        },
      },
      g = {
        name = 'Git',
        -- a = { "<cmd>!git add %:p<CR>", "add current" },
        A = { '<cmd>!git add .<CR>', 'add all' },
        b = { '<cmd>lua require("internal.blame").open()<CR>', 'blame' },
        B = { '<cmd>Telescope git_branches<CR>', 'branches' },
        c = {
          name = 'Conflict',
          b = { '<cmd>GitConflictChooseBoth<CR>', 'choose both' },
          n = { '<cmd>GitConflictNextConflict<CR>', 'move to next conflict' },
          o = { '<cmd>GitConflictChooseOurs<CR>', 'choose ours' },
          p = { '<cmd>GitConflictPrevConflict<CR>', 'move to prev conflict' },
          t = { '<cmd>GitConflictChooseTheirs<CR>', 'choose theirs' },
        },
        D = { '<cmd>lua require("plugins.git.diffview").toggle_file_history()<CR>', 'diff file' },
        g = { '<cmd>LazyGit<CR>', 'lazygit' },
        h = {
          name = 'Hunk',
          d = 'diff hunk',
          p = 'preview',
          R = 'reset buffer',
          r = 'reset hunk',
          s = 'stage hunk',
          S = 'stage buffer',
          t = 'toggle deleted',
          u = 'undo stage',
        },

        l = {
          name = 'Log',
          A = { '<cmd>lua require("plugins.telescope").my_git_commits()<CR>', 'commits (Telescope)' },
          a = { '<cmd>LazyGitFilter<CR>', 'commits' },
          C = { '<cmd>lua require("plugins.telescope").my_git_bcommits()<CR>', 'buffer commits (Telescope)' },
          c = { '<cmd>LazyGitFilterCurrentFile<CR>', 'buffer commits' },
        },
        m = { 'blame line' },
        s = { '<cmd>lua require("plugins.git.diffview").toggle_status()<CR>', 'status' },
        S = { '<cmd>Telescope git_status<CR>', 'telescope status' },
        w = {
          name = 'Worktree',
          w = 'worktrees',
          c = 'create worktree',
        },
      },
      h = {
        name = 'harpoon',
      },
      L = {
        name = 'Lf',
      },
      m = {
        name = 'Marks Add  MarkdownPreview',
        a = { '<cmd>silent BookmarkAnnotate<cr>', 'Marks Annotate' },
        c = { '<cmd>silent BookmarkClear<cr>', 'Marks Clear' },
        j = { '<cmd>silent BookmarkNext<cr>', 'Marks Next' },
        k = { '<cmd>silent BookmarkPrev<cr>', 'Marks Prev' },
        s = { '<cmd>silent BookmarkShowAll<cr>', 'Marks ShowAll' },
        t = { '<cmd>silent BookmarkToggle<cr>', 'Marks Toggle' },
        x = { '<cmd>BookmarkClearAll<cr>', 'Marks Clear All' },
        p = { '<cmd>silent MarkdownPreviewToggle<cr>', 'MarkdownPreviewToggle' },
      },
      o = {
        name = 'Mason  Terminal Float  Open URL  Octo',
        l = { '<cmd>silent !$BROWSER https://github.com/lcdse7en&<cr>', 'Open Github: lcdse7en' }, --  NOTE: :silent 静默执行 & 后台运行
        o = {
          name = 'Octo',
          i = {
            name = 'octo issues',
          },
          -- l = { "<cmd>Lspsaga outline<cr>", "Lspsaga [O]ut[L]ine" },
          r = {
            name = 'octo repo',
          },
        },
        r = {
          name = 'register open url',
          g = { ':silent !$BROWSER https://github.com/<C-r>+&<cr>', 'Open https://github.com/++(On Register)' },
          u = { ':silent !$BROWSER <C-r>+&<cr>', 'Open URL(On Register)' },
        },
      },
      p = {
        name = 'Project',
        p = { --  NOTE: -- sudo pacman -S plocate && sudo updatedb
          "<cmd>lua require'telescope'.extensions.repo.cached_list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}<CR>",
          'Project lists',
        },
      },
      r = {
        name = 'rename on LSP',
      },
      s = {
        name = 'spectre  Source vimrc',
      },
      w = {
        name = 'Window Picker',
      },
      z = {
        name = 'ZenMode',
      },
    }

    local visual_mode_mappings = {
      t = {
        name = 'Table Mode',
        t = { 'tableize' },
      },
    }

    -- ============================================================
    -- register
    -- ============================================================
    wk.register(normal_mode_mappings, opts)
    wk.register(visual_mode_mappings, visual_opts)
  end,
}
