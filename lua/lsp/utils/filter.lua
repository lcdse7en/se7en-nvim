--********************************************
-- Author      : se7enlcd
-- E-mail      : 2353442022@qq.com
-- Create_Time : 2023-07-13 03:12
-- Description :
--********************************************

local M = {}

M.filter = function(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

return M
