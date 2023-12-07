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


del('n', 'Y')
