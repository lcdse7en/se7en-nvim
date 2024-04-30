return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  enabled = true,
  config = function()
    local notify = require 'notify'
    vim.notify = notify

    -- vim.api.nvim_create_autocmd('FileType', {
    --   group = vim.api.nvim_create_augroup('typst_error', { clear = true }),
    --   pattern = 'typst',
    --   callback = function()
    --     local banned_messages =
    --       { '...local/share/nvim/lazy/nvim-cmp/lua/cmp/utils/snippet.lua:409: snippet parsing failed.' }
    --
    --     vim.notify = function(msg, ...)
    --       for _, banned in ipairs(banned_messages) do
    --         if msg == banned then
    --           return
    --         end
    --       end
    --       require 'notify'(msg, ...)
    --     end
    --   end,
    -- })
  end,
}
