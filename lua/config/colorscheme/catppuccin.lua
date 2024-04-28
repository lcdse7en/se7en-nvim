vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha

require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  color_overrides = {
    all = {
      text = '#ffffff',
    },
    latte = {
      base = '#ff0000',
      mantle = '#242424',
      crust = '#474747',
    },
    frappe = {},
    macchiato = {},
    mocha = {},
  },
  highlight_overrides = {
    all = function(colors)
      return {
        NvimTreeNormal = { bg = colors.none, fg = colors.none },
        CmpBorder = { fg = '#3e4145' },
      }
    end,
    latte = function(latte)
      return {
        Normal = { fg = latte.base },
      }
    end,
    frappe = function(frappe)
      return {
        ['@comment'] = { fg = frappe.surface2, style = { 'italic' } },
      }
    end,
    macchiato = function(macchiato)
      return {
        LineNr = { fg = macchiato.overlay1 },
      }
    end,
    mocha = function(mocha)
      return {
        Comment = { fg = mocha.flamingo },
      }
    end,
  },
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  transparent_background = false,
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false,
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  compile = {
    enabled = true,
    path = vim.fn.stdpath 'cache' .. '/catppuccin',
  },
  styles = {
    comments = PREF.ui.italic_comment and { 'italic' } or {},
    conditionals = { 'bold' },
    loops = { 'italic' },
    functions = { 'italic' },
    keywords = { 'italic' },
    strings = {},
    variables = { 'bold' },
    numbers = { 'bold' },
    booleans = { 'bold' },
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    nvimtree = true,
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = {},
        hints = {},
        warnings = {},
        information = {},
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    coc_nvim = false,
    lsp_trouble = false,
    cmp = true,
    flash = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    leap = false,
    telescope = true,
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = true,
    hop = false,
    notify = true,
    telekasten = false,
    symbols_outline = false,
    mini = false,
    aerial = false,
    vimwiki = true,
    beacon = false,
    navic = false,
    overseer = false,
  },
  default_integrations = false,
}
