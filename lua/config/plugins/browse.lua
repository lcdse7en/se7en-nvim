return {
  'lalitmee/browse.nvim',
  enable = true,
  dependencies = 'nvim-telescope/telescope.nvim',
  cmd = {
    'BrowseBookmarks',
    'BrowseInputSearch',
  },
  config = function()
    local browse = require('browse')

    browse.setup({
      -- provider = "brave",
      provider = 'bing',
    })

    local bookmarks = {
      -- simple and direct urls

      ['mygh'] = 'https://github.com/lcdse7en',

      --  NOTE: BiliBili
      ['bili'] = {
        ['name'] = 'BiliBili',
        ['bili'] = 'https://www.bilibili.com/',
        ['mybili'] = 'https://member.bilibili.com/platform/upload-manager/article',
      },
      --  NOTE: Search code repositories issues from github
      ['github'] = {
        ['name'] = 'search github code repo issues',
        ['code_search'] = 'https://github.com/search?q=%s&type=code',
        ['repo_search'] = 'https://github.com/search?q=%s&type=repositories',
        ['issues_search'] = 'https://github.com/search?q=%s&type=issues',
        ['nvim-config-repo'] = 'https://github.com/search?q=nvim config&type=repositories',
      },
    }

    local function command(name, rhs, opts)
      opts = opts or {}
      vim.api.nvim_create_user_command(name, rhs, opts)
    end

    command('Browse', function()
      browse.browse({ bookmarks = bookmarks })
    end, {})

    command('BrowseBookmarks', function()
      browse.open_bookmarks({ bookmarks = bookmarks })
    end, {})

    command('BrowseInputSearch', function()
      browse.input_search()
    end, {})
  end,
}
