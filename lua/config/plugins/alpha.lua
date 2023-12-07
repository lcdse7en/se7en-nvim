local u = require('utils')

return {
  'goolord/alpha-nvim',
  enabled = true,
  event = 'VimEnter',
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local icons = require('utils.icons')
    local if_nil = vim.F.if_nil
    local fn = vim.fn
    local config_dir = fn.stdpath('config')

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Header                                                   │
    -- ╰──────────────────────────────────────────────────────────╯

    -- local header = {
    --   " ████████                           ██            ",
    --   "░██░░░░░                           ░░             ",
    --   "░██        █████   ██████  ██    ██ ██ ██████████ ",
    --   "░███████  ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██",
    --   "░██░░░░  ░██  ░░ ░██   ░██░░██ ░██ ░██ ░██ ░██ ░██",
    --   "░██      ░██   ██░██   ░██ ░░████  ░██ ░██ ░██ ░██",
    --   "░████████░░█████ ░░██████   ░░██   ░██ ███ ░██ ░██",
    --   "░░░░░░░░  ░░░░░   ░░░░░░     ░░    ░░ ░░░  ░░  ░░ ",
    -- }

    local header = {
      '                                                                               ',
      '            ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z',
      '            ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    ',
      '            ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       ',
      '            ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         ',
      '            ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           ',
      '            ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           ',
      '                                                                               ',
    }

    dashboard.section.header.type = 'text'
    dashboard.section.header.val = header
    dashboard.section.header.opts = {
      position = 'center',
      hl = 'Se7envimHeader',
    }

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Heading Info                                             │
    -- ╰──────────────────────────────────────────────────────────╯

    local thingy =
      io.popen('echo "$(LANG=en_us_88591; date +%a) $(date +%d) $(LANG=en_us_88591; date +%b)" | tr -d "\n"')
    if thingy == nil then
      return
    end
    local date = thingy:read('*a')
    thingy:close()

    local datetime = os.date(' %H:%M')

    local hi_top_section = {
      type = 'text',
      val = '┌────────────   Today is '
        .. date
        .. ' ────────────┐',
      opts = {
        position = 'center',
        hl = 'Se7envimHeaderInfo',
      },
    }

    local hi_middle_section = {
      type = 'text',
      val = '│                                                │',
      opts = {
        position = 'center',
        hl = 'Se7envimHeaderInfo',
      },
    }

    local hi_bottom_section = {
      type = 'text',
      val = '└───══───══───══───  '
        .. datetime
        .. '  ───══───══───══────┘',
      opts = {
        position = 'center',
        hl = 'Se7envimHeaderInfo',
      },
    }

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Buttons                                                  │
    -- ╰──────────────────────────────────────────────────────────╯
    -- Copied from Alpha.nvim source code

    local leader = 'SPC'

    --- @param sc string
    --- @param txt string
    --- @param keybind string optional
    --- @param keybind_opts table optional
    local function button(sc, txt, keybind, keybind_opts)
      local sc_ = sc:gsub('%s', ''):gsub(leader, '<leader>')

      local opts = {
        position = 'center',
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = 'right',
        hl_shortcut = 'Se7envimPrimary',
      }
      if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { 'n', sc_, keybind, keybind_opts }
      end

      local function on_press()
        -- local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
        local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
        vim.api.nvim_feedkeys(key, 't', false)
      end

      return {
        type = 'button',
        val = txt,
        on_press = on_press,
        opts = opts,
      }
    end

    dashboard.section.buttons.val = {
      button('p', '  ' .. ' ' .. 'Open Project', '<cmd>Telescope project display_type=full<cr>', {}),
      button('f', '  ' .. ' ' .. 'Find File', "<cmd>lua require('plugins.telescope').project_files()<CR>", {}),
      button('t', icons.t .. ' ' .. 'Find Text', "<cmd>lua require('plugins.telescope.pickers.multi-rg')()<CR>", {}),
      button('r', icons.fileRecent .. ' ' .. 'Recents Files', '<cmd>Telescope oldfiles hidden=true<CR>', {}),
      button('s', '  ' .. ' ' .. 'Load Last Session', '<cmd>SessionManager load_last_session<CR>', {}),
      button('u', icons.container .. ' ' .. 'Lazy update', '<cmd>Lazy update<CR>', {}),
      button('l', '💤 ' .. ' ' .. 'Lazy', '<cmd>Lazy<CR>', {}),
      button('m', '  ' .. ' ' .. 'Mason', '<cmd>Mason<CR>', {}),
      button('c', icons.cog .. ' ' .. 'Config File', '<cmd>e $MYVIMRC<CR>', {}),
      button('q', icons.exit .. ' ' .. 'Exit', '<cmd>exit<CR>', {}),
    }
    -- Add
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'
    dashboard.opts.layout[1].val = 8

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Footer                                                   │
    -- ╰──────────────────────────────────────────────────────────╯

    local function file_exists(file)
      local f = io.open(file, 'rb')
      if f then
        f:close()
      end
      return f ~= nil
    end

    local function line_from(file)
      if not file_exists(file) then
        return {}
      end
      local lines = {}
      for line in io.lines(file) do
        lines[#lines + 1] = line
      end
      return lines
    end

    local function footer()
      local plugins = require('lazy').stats().count
      local v = vim.version()
      local se7envim_version = line_from(config_dir .. '/.se7envim.version')
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      -- return string.format(" v%d.%d.%d   %d   %s", v.major, v.minor, v.patch, plugins, se7envim_version[1])
      return ' v'
        .. v.major
        .. '.'
        .. v.minor
        .. '.'
        .. v.patch
        .. '  '
        .. ' ⚡ Neovim loaded '
        .. plugins
        .. ' plugins in '
        .. ms
        .. 'ms'
    end

    dashboard.section.footer.val = {
      footer(),
    }
    dashboard.section.footer.opts = {
      position = 'center',
      hl = 'Se7envimFooter',
    }

    local section = {
      header = dashboard.section.header,
      hi_top_section = hi_top_section,
      hi_middle_section = hi_middle_section,
      hi_bottom_section = hi_bottom_section,
      buttons = dashboard.section.buttons,
      footer = dashboard.section.footer,
    }

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Setup                                                    │
    -- ╰──────────────────────────────────────────────────────────╯

    local opts = {
      layout = {
        { type = 'padding', val = 3 },
        section.header,
        { type = 'padding', val = 1 },
        section.hi_top_section,
        section.hi_middle_section,
        section.hi_bottom_section,
        { type = 'padding', val = 2 },
        section.buttons,
        { type = 'padding', val = 3 },
        section.footer,
      },
      opts = {
        margin = 5,
      },
    }

    alpha.setup(opts)

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Hide tabline and statusline on startup screen            │
    -- ╰──────────────────────────────────────────────────────────╯
    vim.api.nvim_create_augroup('alpha_tabline', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = 'alpha_tabline',
      pattern = 'alpha',
      command = 'set showtabline=0 laststatus=0 noruler',
    })

    vim.api.nvim_create_autocmd('FileType', {
      group = 'alpha_tabline',
      pattern = 'alpha',
      callback = function()
        vim.api.nvim_create_autocmd('BufUnload', {
          group = 'alpha_tabline',
          buffer = 0,
          command = 'set showtabline=2 ruler laststatus=3',
        })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        dashboard.section.footer.val = footer()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
