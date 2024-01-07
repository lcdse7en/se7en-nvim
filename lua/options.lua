local textwidth = PREF.common.textwidth
local tabwidth = PREF.common.tabwidth

local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
local langmap = vim.fn.join({
  escape(ru_shift) .. ';' .. escape(en_shift),
  escape(ru) .. ';' .. escape(en),
}, ',')

local options = {
  clipboard = "unnamed,unnamedplus",     --- Copy-paste between vim and everything else
  number = true,                         --- Shows current line number
  relativenumber = true,                 --- Enables relative number
  textwidth = PREF.common.textwidth,
  colorcolumn = tostring(textwidth),
  termguicolors = true,
  numberwidth = 4,
  cursorline = true,                     --- Highlight of current line
  mouse = "a",                           --- Enable mouse
  cmdheight = 0,                         --- Give more space for displaying messages
  pumheight = 10,                        --- Max num of items in completion menu
  signcolumn = "yes",                    --- Add extra sign column next to line number
  history = 10000,
  scrolloff = 12,                        --- Always keep space when scrolling to bottom/top edge
  sidescrolloff = 12,
  laststatus = 3,                        --- global statusline
  expandtab = true,                      --- Use spaces instead of tabs
  smarttab = true,                       --- Makes tabbing smarter will realize you have 2 vs 4
  cindent = true,
  shiftwidth = tabwidth,
  tabstop = tabwidth,
  ignorecase = true,
  smartcase = true,                      --- Uses case in search
  hlsearch = true,
  infercase = true,
  autoindent = true,                     --- Good auto indent
  smartindent = true,                    --- Makes indenting smart
  errorbells = false,                    --- Disables sound effect for errors
  fileencoding = "utf-8",                --- The encoding written to file
  grepprg = "rg --hidden --vimgrep --smart-case --",
  backup = false,
  swapfile = false,
  wrap = false,
  linebreak = true,
  completeopt = "menu,menuone,noselect", --- Better autocompletion
  undofile = true,                       --- Sets undo to file
  undodir = os.getenv "HOME" .. "/.cache/nvim/undodir",
  timeoutlen = 350,                      --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
  ttimeoutlen = 10,
  redrawtime = 1500,
  updatetime = 50,                       --- Faster completion
  viminfo = "'1000",                     --- Increase the size of file history
  confirm = false,                       --- Confirm to save changes before exiting modified buffer
  incsearch = true,                      --- Start searching before pressing enter
  writebackup = false,                   --- Not needed
  copyindent = true,                     --- copy the previous indentation on autoindenting
  conceallevel = 0,                      --- Show `` in markdown files
  spell = false,
  guifont = "FiraCode Nerd Font Regular",
  spelllang = 'en_us,ru_ru',
  whichwrap = vim.opt.whichwrap:append('<,>,[,],h,l'),
  shortmess = vim.opt.shortmess:append('c'),
  iskeyword = vim.opt.iskeyword:append('-'),
  langmap = langmap,
  -- ============================================================
  -- Fold  listchars
  -- ============================================================
  list = true,                           --- enable or disable listchars
  listchars = { tab = "· ", trail = " ", eol = " ", extends = "→", precedes = "←" },
  foldcolumn = '0',                      --- '0' is not bad
  foldlevel = 99,                        --- Using ufo provider need a large value, feel free to decrease the value
  foldlevelstart = 99,
  foldmethod = "expr",                   --- fold with nvim_treesitter | indent, syntax |
  foldexpr = "nvim_treesitter#foldexpr()",
  foldenable = true,
}

local globals = {
  mapleader = " ",                       --- Map leader key to SPC
  cmp_enabled = false,                   --- enable completion at start
  codelens_enabled = true,               --- enable or disable automatic codelens refreshing for lsp that support it
  icons_enabled = true,                  --- disable icons in the UI (disable if no nerd font is available)
  speeddating_no_mappings = 1,           --- Disable default mappings for speeddating
  tex_flavor = "latex",                  --- set latex filetypes
  autoformat_enabled = false,
  diagnostics_mode = 3,                  --- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
  highlighturl_enabled = true,           --- highlight URLs by                                                                                  default
  lsp_handlers_enabled = true,           --- enable or disable default vim.lsp.handlers (hover and signature                                    help)
  semantic_tokens_enabled = true,        --- enable or disable LSP semantic tokens on                                                        startup
  ui_notifications_enabled = true,       --- disable notifications (TODO: rename to  notifications_enabled in AstroNvim v4)
  git_worktrees = nil,                   --- enable git integration for detached worktrees (specify a table where each entry is of the form { toplevel = vim.env.HOME, gitdir=vim.env.HOME .. "/.dotfiles" })
  resession_enabled = true,
  transparent_background = true,
  inlay_hints_enabled = true,            ---  NOTE: enable or disable LSP inlay hints on startup (Neovim v0.10+ only)
}

for option_name, value in pairs(options) do
	local ok, _ = pcall(vim.api.nvim_get_option_info2, option_name, {})
	if ok then
		vim.opt[option_name] = value
	else
		vim.notify('Option ' .. option_name .. ' is not supported', vim.log.levels.WARN)
	end
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
