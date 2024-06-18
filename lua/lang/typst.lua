local M = {}

local ts_utils = require 'nvim-treesitter.ts_utils'

M.in_mode = function()
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == 'math' then
      return true
    end
    node = node:parent()
  end
  return false
end

M.in_mathzone = function()
  return M.in_mode()
end

M.in_text = function()
  return not M.in_mode()
end

return M
