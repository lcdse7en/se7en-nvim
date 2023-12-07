-- ============================================================================
-- se7en configure
-- ============================================================================
local map = vim.keymap.set
local del = vim.keymap.del
local u = require('utils')
local cb = u.lazy_rhs_cb

-- Escape mappings
for _, keys in ipairs(PREF.common.escape_keys) do
  map('t', keys, [[<C-\><C-n>]], { desc = 'Leave INSERT mode in terminal' })
  map('i', keys, '<Esc>', { desc = 'Leave INSERT mode' })
end
map('t', '<esc>', [[<C-\><C-n>]], { desc = 'Leave INSERT mode in terminal' })

map('t', '<esc>', [[<C-\><C-n>]], { desc = 'Leave INSERT mode in terminal' })

map("n", "<leader>r", "<cmd>silent source $MYVIMRC<cr>", { silent = true, desc = "source vimrc" })

-- save in insert mode
map("i", "<C-s>", "<cmd>:w<cr><esc>", { silent = true })
map("n", "<C-s>", "<cmd>:w<cr><esc>", { silent = true })
map('n', 'W', ':w<cr>', { silent = true })

map('n', '<leader>q', '<cmd>q<cr>', {silent = true, desc = 'close' })

-- Delete a word backwards
map("n", "dw", "vb_d", { silent = true } )

map('n', 'H', '^', { silent = true })
map('n', 'L', '$', { silent = true })
map('x', '<', '<gv', { desc = 'One indent left and reselect' })
map('x', '>', '>gv|', { desc = 'One indent right and reselect' })
map('v', 'sa', cb('modules.surround', 'add_visual'))
map('n', 'sa', cb('modules.surround', 'add'))
map('n', 'sr', cb('modules.surround', 'remove'))
map('n', 'sc', cb('modules.surround', 'replace'))

-- Better window movement
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

--- Copy-paste
map("n", "<leader>C", 'gg"+yG', { desc = "Copy whole file" })

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", { silent = true })
map("x", "J", ":move '>+1<CR>gv-gv", { silent = true })

map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  desc = 'Move cursor down (display and real line)',
})
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  desc = 'Move cursor up (display and real line)',
})
-- Remove highlights
map("n", "<leader><CR>", ":nohlsearch<CR>", { silent = true, desc = ":nohlsearch" })
map("n", "<ESC>", ":noh<CR>", { silent = true, desc = "nohlsearch" })
-- Don't yank on delete char
map("n", "x", '"_x', { silent = true })
map("n", "X", '"_X', { silent = true })
map("v", "x", '"_x', { silent = true })
map("v", "X", '"_X', { silent = true })


-- Increment/decrement
map("n", "+", "<C-a>", { silent = true })
map("v", "+", "<C-a>", { silent = true })
map("n", "-", "<C-x>", { silent = true })
map("v", "-", "<C-x>", { silent = true })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { silent = true })

--  NOTE: hlslens
map(
  "n",
  "n",
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { noremap = true, silent = true }
)
map(
  "n",
  "N",
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { noremap = true, silent = true }
)
map(
  "n",
  "*",
  [[*<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { noremap = true, silent = true }
)

-- Buffers
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "gn", ":bn<CR>", { silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
map("n", "gp", ":bp<CR>", { silent = true })

-- Move between barbar buffers
map("n", "<Space>1", ":BufferLineGoToBuffer 1<CR>", { silent = true })
map("n", "<Space>2", ":BufferLineGoToBuffer 2<CR>", { silent = true })
map("n", "<Space>3", ":BufferLineGoToBuffer 3<CR>", { silent = true })
map("n", "<Space>4", ":BufferLineGoToBuffer 4<CR>", { silent = true })
map("n", "<Space>5", ":BufferLineGoToBuffer 5<CR>", { silent = true })
map("n", "<Space>6", ":BufferLineGoToBuffer 6<CR>", { silent = true })
map("n", "<Space>7", ":BufferLineGoToBuffer 7<CR>", { silent = true })
map("n", "<Space>8", ":BufferLineGoToBuffer 8<CR>", { silent = true })
map("n", "<Space>9", ":BufferLineGoToBuffer 9<CR>", { silent = true })
map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", { silent = true })
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", { silent = true })
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", { silent = true })
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", { silent = true })
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", { silent = true })
map("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", { silent = true })
map("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", { silent = true })
map("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", { silent = true })
map("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", { silent = true })

-- Open url at cursor in browser
map("n", "<Leader>ou", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local col, _ = vim.api.nvim_get_current_line():find "https?"
  if not col then
    return
  end
  vim.api.nvim_win_set_cursor(0, { pos[1], col - 1 })
  open_url(vim.fn.expand "<cfile>")
  vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Open URL(On underline)" })

-- Open plugin repository at cursor in browser
map("n", "<Leader>og", function()
  open_url(vim.fn.expand "<cfile>", [[https://github.com/]])
end, { desc = "Search Gihub(On underline)" })

del('n', 'Y')

