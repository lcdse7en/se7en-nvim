local function set_prior(c)
  c = type(c) == 'table' and c or { c }
  c.priority = 1000
  return c
end

return vim.tbl_map(set_prior, {
  {
    'catppuccin/nvim',
    -- name = 'catppuccin',
    -- init = function()
    --   vim.g.catppuccin_flavour = 'mocha'
    -- end,
    -- lazy = false,
    priority = 1000,
  },
  'Mofiqul/vscode.nvim',
  'dasupradyumna/midnight.nvim',
  { 'folke/tokyonight.nvim', lazy = true, priority = 1000 },
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
