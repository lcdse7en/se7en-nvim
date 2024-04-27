local function set_prior(c)
  c = type(c) == 'table' and c or { c }
  c.priority = 1000
  return c
end

return vim.tbl_map(set_prior, {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- init = function()
    --   vim.g.catppuccin_flavour = 'mocha'
    -- end,
    -- lazy = false,
    priority = 1000,
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = true, custom_bg = 'lualine' },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  'Mofiqul/vscode.nvim',
  'dasupradyumna/midnight.nvim',
  { 'folke/tokyonight.nvim', lazy = true, priority = 1000, opts = { style = 'moon' } },
  'loctvl842/monokai-pro.nvim',
  'rebelot/kanagawa.nvim',
  'sainnhe/gruvbox-material',
  'sam4llis/nvim-tundra',
  'LunarVim/darkplus.nvim',
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    -- 'Wansmer/serenity.nvim',
    -- dev = false,
    dir = '~/projects/code/personal/serenity.nvim',
    name = 'serenity',
  },
  -- {
  --   'Jint-lzxy/nvim',
  --   lazy = false,
  --   -- branch = 'refactor/syntax-highlighting',
  --   name = 'catppuccin',
  -- },
  { 'neanias/everforest-nvim', version = false },
  { 'ramojus/mellifluous.nvim', dependencies = { 'rktjmp/lush.nvim' } },
  { 'rose-pine/neovim', name = 'rose-pine' },
})
