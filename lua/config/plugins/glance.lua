--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 14:05:50         *
-- Description :                             *
--********************************************



return {
  'dnlhc/glance.nvim',
  cmd = { "Glance" },
  keys = {
    { "gd", "<cmd>Glance definitions<CR>", desc = "LSP Definition" },
    { "gr", "<cmd>Glance references<CR>", desc = "LSP References" },
    { "gi", "<cmd>Glance implementations<CR>", desc = "LSP Implementations" },
    { "gt", "<cmd>Glance type_definitions<CR>", desc = "LSP Type Definitions" },
  },
  config = function()
    local filter = require("lsp.utils.filter").filter
    local filterReactDTS = require("lsp.utils.filterReactDTS").filterReactDTS

    require("glance").setup {
      hooks = {
        before_open = function(results, open, jump, method)
          if #results == 1 then
            jump(results[1]) -- argument is optional
          elseif method == "definitions" then
            results = filter(results, filterReactDTS)
            open(results)
          else
            open(results)
          end
        end,
      },
    }
  end,
}
