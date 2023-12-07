return {
  'folke/todo-comments.nvim',
  event = 'BufEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local todo_comments = require('todo-comments')
    local error_red = '#F44747'
    local warning_orange = '#ff8800'
    local info_yellow = '#FFCC66'
    local hint_blue = '#4FC1FF'
    local perf_purple = '#7C3AED'
    local note_green = '#10B981'

    todo_comments.setup({
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = '', -- icon used for the sign, and in search results
          color = error_red, -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = '', color = hint_blue, alt = { 'TIP' } },
        HACK = { icon = '', color = warning_orange },
        WARN = { icon = '', color = warning_orange, alt = { 'WARNING', 'XXX' } },
        PERF = { icon = '󰅒', color = perf_purple, alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = '󰍨', color = note_green, alt = { 'INFO' } },
        TEST = { icon = '󰍁', color = info_yellow, alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
      gui_style = {
        fg = 'NONE', -- The gui style to use for the fg highlight group.
        bg = 'BOLD', -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = '', -- "fg" or "bg" or empty
        keyword = 'wide', -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = 'fg', -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = { 'help', 'checkhealth' }, -- list of file types to exclude highlighting
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    })

    -- ╭──────────────────────────────────────────────────────────╮
    -- │  Keymappings                                             │
    -- ╰──────────────────────────────────────────────────────────╯

    vim.keymap.set('n', ']t', function()
      require('todo-comments').jump_next()
    end, { desc = 'Next todo comment' })
    vim.keymap.set('n', '[t', function()
      require('todo-comments').jump_prev()
    end, { desc = 'Previous todo comment' })
  end,
}
