--********************************************
-- Author      : se7enlcd
-- E-mail      : 2353442022@qq.com
-- Create_Time : 2023-07-13 03:13
-- Description :
--********************************************

local M = {}

M.filterReactDTS = function(value)
  -- Depending on typescript version either uri or targetUri is returned
  if value.uri then
    return string.match(value.uri, "%.d.ts") == nil
  elseif value.targetUri then
    return string.match(value.targetUri, "%.d.ts") == nil
  end
end

return M
