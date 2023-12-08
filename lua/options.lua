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
  clipboard = "unnamed,unnamedplus",    --- Copy-paste between vim and everything else
  number = true,
  relativenumber = true,                --- Enables relative number
  termguicolors = true,
  numberwidth = 4,
  cursorline = true,
  mouse = "a",                          --- Enable mouse
  cmdheight = 0,
  pumheight = 10,
  signcolumn = 'yes',
  history = 10000,
  scrolloff = 5,
  sidescrolloff = 5,
  colorcolumn = tostring(textwidth),
  laststatus = 3,
  expandtab = true,                     --- Use spaces instead of tabs
  smarttab = true,
  cindent = true,
  shiftwidth = tabwidth,
  tabstop = tabwidth,
  ignorecase = true,
  smartcase = true,
  hlsearch = true,
  infercase = true,
  grepprg = "rg --hidden --vimgrep --smart-case --",
  autoindent = true,                     --- Good auto indent
  smartindent = true,                    --- Makes indenting smart
  backup = false,
  swapfile = false,
  textwidth = PREF.common.textwidth,
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
  spell = false,
  conceallevel = 0,                      --- Show `` in markdown files
  guifont = "FiraCode Nerd Font Regular",
  spelllang = 'en_us,ru_ru',
  whichwrap = vim.opt.whichwrap:append('<,>,[,],h,l'),
  shortmess = vim.opt.shortmess:append('c'),
  iskeyword = vim.opt.iskeyword:append('-'),
  langmap = langmap,
  smoothscroll = true,
}

local globals = {
  mapleader = " ",                --- Map leader key to SPC
  speeddating_no_mappings = 1,    --- Disable default mappings for speeddating
  tex_flavor = "latex",           --- set latex filetypes
  autoformat_enabled = false,
  icons_enabled = true,
  diagnostics_mode = 3,           --- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
  highlighturl_enabled = true,    --- highlight URLs by                                                                                  default
  lsp_handlers_enabled = true,    --- enable or disable default vim.lsp.handlers (hover and signature                                    help)
  semantic_tokens_enabled = true, --- enable or disable LSP semantic tokens on                                                        startup
  resession_enabled = true,
  transparent_background = true,
  inlay_hints_enabled = true,     ---  NOTE: enable or disable LSP inlay hints on startup (Neovim v0.10+ only)
  browser = "google-chrome-stable",
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
