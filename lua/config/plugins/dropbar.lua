return {
  'Bekaboo/dropbar.nvim',
  enabled = true,
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  opts = {
    border = 'none',
    style = 'minimal',
    row = function(menu)
      return menu.prev_menu and menu.prev_menu.clicked_at and menu.prev_menu.clicked_at[1] - vim.fn.line 'w0' or 0
    end,
    ---@param menu dropbar_menu_t
    col = function(menu)
      if menu.prev_menu then
        return menu.prev_menu._win_configs.width + (menu.prev_menu.scrollbar and 1 or 0)
      end
      local mouse = vim.fn.getmousepos()
      local bar = require('dropbar.api').get_dropbar(vim.api.nvim_win_get_buf(menu.prev_win), menu.prev_win)
      if not bar then
        return mouse.wincol
      end
      local _, range = bar:get_component_at(math.max(0, mouse.wincol - 1))
      return range and range.start or mouse.wincol
    end,
    relative = 'win',
    win = function(menu)
      return menu.prev_menu and menu.prev_menu.win or vim.fn.getmousepos().winid
    end,
    height = function(menu)
      return math.max(
        1,
        math.min(#menu.entries, vim.go.pumheight ~= 0 and vim.go.pumheight or math.ceil(vim.go.lines / 4))
      )
    end,
    width = function(menu)
      local min_width = vim.go.pumwidth ~= 0 and vim.go.pumwidth or 8
      if vim.tbl_isempty(menu.entries) then
        return min_width
      end
      return math.max(
        min_width,
        math.max(unpack(vim.tbl_map(function(entry)
          return entry:displaywidth()
        end, menu.entries)))
      )
    end,
    zindex = function(menu)
      if menu.prev_menu then
        if menu.prev_menu.scrollbar and menu.prev_menu.scrollbar.thumb then
          return vim.api.nvim_win_get_config(menu.prev_menu.scrollbar.thumb).zindex
        end
        return vim.api.nvim_win_get_config(menu.prev_win).zindex
      end
    end,
  },
}
