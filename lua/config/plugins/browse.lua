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
      -- sudo pacman -S brave
      provider = 'brave',
      -- provider = 'bing',
      -- provider = 'firefox',
    }

    local bookmarks = {
      -- simple and direct urls

      ['mygh'] = 'https://github.com/lcdse7en',
      ['nerdfonts'] = 'https://www.nerdfonts.com/cheat-sheet',
      ['wallpaper'] = 'https://alphacoders.com/k%E2%80%93pop-4k-wallpapers',
      ['Ruixi-rebirth-nixos-config'] = 'https://github.com/Ruixi-rebirth?tab=repositories',
      ['tjdevries'] = 'https://github.com/tjdevries',

      --  NOTE: localhost
      ['localhost'] = {
        ['name'] = 'Localhost:127.0.0.1',
        ['server'] = 'http://localhost:8000',
        ['torrent'] = 'http://localhost:9091',
      },

      --  NOTE: Chorme extensions
      ['chrome-extension'] = {
        ['name'] = 'chrome extensions',
        ['zzzmh'] = 'https://chrome.zzzmh.cn/#/extension',
        ['pictureknow'] = 'https://chrome.pictureknow.com/',
      },

      --  NOTE: typst ebook
      ['typst-ebook'] = 'https://github.com/typst-doc-cn/tutorial',

      --  NOTE: scoop
      ['scoop'] = 'http://scoop.sh',

      --  NOTE: icons png svg jpg gif
      ['svg'] = {
        ['name'] = 'svg',
        ['svg'] = 'https://www.svgrepo.com/',
        ['icons'] = 'https://icons8.com/icons/set/arch-linux',
      },

      --  NOTE: hyprland
      ['hypr'] = {
        ['name'] = 'Hyprland',
        ['install'] = 'https://github.com/kshitijdhara/Arch-hyprland',
        ['hypr-config'] = 'https://github.com/prasanthrangan/hyprdots',
      },

      --  NOTE: wezterm
      ['wezterm'] = {
        ['name'] = 'Wezterm_config',
        ['KevinSilvester'] = 'https://github.com/KevinSilvester/wezterm-config?tab=readme-ov-file',
        ['QianSong1'] = 'https://github.com/QianSong1/wezterm-config',
      },

      --  NOTE: Typst
      ['typst'] = {
        ['name'] = 'Typst Doc temp and Packages',
        ['zh-doc'] = 'https://typst-doc-cn.github.io/docs/reference/layout/place/',
        ['typst-packages'] = 'https://typst-doc-cn.github.io/docs/packages/',
        ['typst-preview'] = 'https://githubfast.com/Enter-tainer/typst-preview/releases',
        ['tablex'] = 'https://githubfast.com/PgBiel/typst-tablex',
        ['cetz'] = 'https://github.com/johannes-wolf/cetz',

        -- Pinit包基于图钉pin进行相对定位的能力，可以方便地实现箭头指示与解释说明的效果。
        ['pinit'] = 'https://github.com/OrangeX4/typst-pinit',
      },

      --  NOTE: Colors table
      ['colors'] = {
        ['name'] = 'Colors Table',
        ['ColorHexa'] = 'https://www.colorhexa.com/color-names',
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
        ['craftzdog'] = 'https://github.com/craftzdog/dotfiles-public/tree/master/.config/nvim',
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
        ['hanju'] = 'https://v.ijujitv.cc/show/1-----------2024.html',
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
