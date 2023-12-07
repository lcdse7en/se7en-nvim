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
  numberwidth = 3,
  cursorline = true,
  mouse = "a",                          --- Enable mouse
  cmdheight = 0,
  pumheight = 10,
  signcolumn = 'yes',
  scrolloff = 3,
  sidescrolloff = 3,
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
  autoindent = true,                    --- Good auto indent
  smartindent = true,                   --- Makes indenting smart
  backup = false,
  swapfile = false,
  textwidth = PREF.common.textwidth,
  wrap = false,
  linebreak = true,
  timeoutlen = 350,                     --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
  updatetime = 100,                     --- Faster completion
  confirm = false,                      --- Confirm to save changes before exiting modified buffer
  incsearch = true,                     --- Start searching before pressing enter
  spell = false,
  guifont = "FiraCode Nerd Font Regular",
  spelllang = 'en_us,ru_ru',
  whichwrap = vim.opt.whichwrap:append('<,>,[,],h,l'),
  shortmess = vim.opt.shortmess:append('c'),
  iskeyword = vim.opt.iskeyword:append('-'),
  langmap = langmap,
  smoothscroll = true,
}

for option_name, value in pairs(options) do
	local ok, _ = pcall(vim.api.nvim_get_option_info2, option_name, {})
	if ok then
		vim.opt[option_name] = value
	else
		vim.notify('Option ' .. option_name .. ' is not supported', vim.log.levels.WARN)
	end
end
