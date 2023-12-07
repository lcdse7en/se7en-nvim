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
map('n', 'W', ':w<cr>', { silent = true })
map('n', '<leader>q', '<cmd>close<cr>', {silent = true})
map('n', 'H', '^', { silent = true })
map('n', 'L', '$', { silent = true })
map('x', '<', '<gv', { desc = 'One indent left and reselect' })
map('x', '>', '>gv|', { desc = 'One indent right and reselect' })
map('v', 'sa', cb('modules.surround', 'add_visual'))
map('n', 'sa', cb('modules.surround', 'add'))
map('n', 'sr', cb('modules.surround', 'remove'))
map('n', 'sc', cb('modules.surround', 'replace'))

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

-- Comment Box
map("n", "<leader>cb", "<cmd>lua require('comment-box').lbox()<CR>", { silent = true, desc = "Comment Box normal" })
map("v", "<leader>cb", "<cmd>lua require('comment-box').lbox()<CR>", { silent = true, desc = "Comment Box visual" })

-- Increment/decrement
map("n", "+", "<C-a>", { silent = true })
map("v", "+", "<C-a>", { silent = true })
map("n", "-", "<C-x>", { silent = true })
map("v", "-", "<C-x>", { silent = true })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { silent = true })

del('n', 'Y')
