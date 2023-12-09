return {
  'lalitmee/browse.nvim',
  enable = true,
  dependencies = 'nvim-telescope/telescope.nvim',
  cmd = {
    'BrowseBookmarks',
    'BrowseInputSearch',
  },
  config = function()
    local browse = require 'browse'

    browse.setup {
      -- provider = "brave",
      provider = 'bing',
    }

    local bookmarks = {
      -- simple and direct urls

      ['mygh'] = 'https://github.com/lcdse7en',

      --  NOTE: localhost
      ['localhost'] = {
        ['name'] = 'Localhost:127.0.0.1',
        ['server'] = 'http://localhost:8000',
        ['torrent'] = 'http://localhost:9091',
      },
      --  NOTE: hyprland
      ['hypr'] = {
        ['name'] = 'Hyprland',
        ['hyprland'] = 'https://github.com/soldoestech/hyprv4',
      },

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

      --  NOTE: texlive ISO
      ['texlive-ISO'] = {
        ['name'] = 'texlive ISO',
        ['tuna'] = 'https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images',
      },

      --  NOTE: Regular Expression
      ['re'] = {
        ['name'] = 'Regular Expression',
        ['regex101'] = 'https://regex101.com/',
        ['regexr'] = 'https://regexr.com/',
      },

      --  NOTE: nvim config star repo
      ['nvim'] = {
        ['name'] = 'neovim configure repositories of favourites',
        ['neovim'] = 'https://github.com/neovim/neovim/releases/',
        ['bob'] = 'https://github.com/MordechiHadad/bob/releases/tag/', --  PERF: A version manager for Neovim
        ['ecosse3'] = 'https://github.com/ecosse3/nvim',
        ['christianchiarulli'] = 'https://github.com/ChristianChiarulli/nvim',
        ['folke'] = 'https://github.com/folke/dot/tree/master/nvim',
        ['willothy'] = 'https://github.com/willothy/nvim-config',
        ['ayamir'] = 'https://github.com/ayamir/nvimdots',
        ['jdhao'] = 'https://github.com/jdhao/nvim-config',
        ['theniceboy'] = 'https://github.com/theniceboy',
        ['allaman'] = 'https://github.com/Allaman/nvim',
        ['lazyvim'] = 'https://github.com/LazyVim/LazyVim',
        ['astronvim'] = 'https://github.com/AstroNvim/AstroNvim',
        ['telescope'] = 'https://github.com/nvim-telescope/telescope.nvim',
        ['nvim-treesitter'] = 'https://github.com/nvim-treesitter/nvim-treesitter#language-parsers',
        ['craft'] = 'https://neovimcraft.com',
        ['awesome-neovim'] = 'https://github.com/rockerBOO/awesome-neovim',
      },

      --  NOTE: Python tools
      ['python'] = {
        ['name'] = 'Tools and Tutorial for Python',
        ['python'] = 'https://www.python.org/downloads/source/',
        ['pypi'] = 'https://pypi.org',
        ['rye'] = 'https://github.com/mitsuhiko/rye', --  NOTE: Python packages management Tool
        ['python tutorial(zh-cn)'] = 'https://docs.python.org/zh-cn/3/tutorial/index.html',
        ['pandas tutorial(zh-cn)'] = 'https://pypandas.cn/docs/user_guide/',
        ['openpyxl tutorial(zh-cn)'] = 'https://openpyxl-chinese-docs.readthedocs.io/zh_CN/latest/tutorial.html',
        ['re-tool'] = 'https://tool.oschina.net/regex',
      },

      --  NOTE: track
      ['trackerlist'] = 'https://trackerslist.com/#/zh',

      --  NOTE: Korea movie music tv
      ['korea'] = {
        ['name'] = 'Korea movie tv and music',
        ['wiki'] = 'https://namu.wiki/w/',
        ['korea movie(weibo)'] = 'https://m.weibo.cn/u/1965284462',
        ['hanju'] = 'https://www.ijujitv.cc/show/1-----------2023.html',
        -- ["hanju"] = "http://kkhanju.top/",
        ['kpop'] = 'https://www.kpopn.com/category/news',
      },

      --  NOTE: Torrent
      ['torrents'] = {
        ['name'] = 'Torrents download Net',
        -- ["galaxy"] = "https://torrentgalaxy.to/",
        ['rarbgproxy'] = 'https://www.rarbgproxy.to/',
        ['trackerlist'] = 'https://trackerslist.com/#/zh',
      },

      --  NOTE: latex
      ['latex'] = {
        ['name'] = 'Latex tools Net',
        ['texdoc'] = 'https://texdoc.org/index.html',
        ['codecogs'] = 'https://editor.codecogs.com/',
        ['table'] = 'https://www.tablesgenerator.com/',
        ['mathpix'] = 'https://mathpix.com/',
      },
    }

    local function command(name, rhs, opts)
      opts = opts or {}
      vim.api.nvim_create_user_command(name, rhs, opts)
    end

    command('Browse', function()
      browse.browse { bookmarks = bookmarks }
    end, {})

    command('BrowseBookmarks', function()
      browse.open_bookmarks { bookmarks = bookmarks }
    end, {})

    command('BrowseInputSearch', function()
      browse.input_search()
    end, {})
  end,
}
