--*******************************************
-- Author:      lcdse7en                    *
-- E-mail:      2353442022@qq.com           *
-- Date:        2023-05-12                  *
-- Description:                             *
--*******************************************
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local line_begin = require('luasnip.extras.expand_conditions').line_begin
-- local tex = require "utils.latex"

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s(
    { trig = 'myarr', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      <>=(
          <>
      )
      ]],
      {
        i(1, 'array'),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myarr',
      dscr = 'array',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    { trig = 'mynote', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      #  <>: <>
      ]],
      {
        c(1, { t 'NOTE', t 'TODO', t 'WARN', t 'FIX', t 'HACK', t 'PERF' }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mycs',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      read -r -p "<>" -e <>
      case "$<>" in
      <>)
          <>
          ;;
      <>)
          <>
          ;;
      *)
          exit
          ;;
      esac
      ]],
      {
        i(1, 'InfoText'),
        i(2, 'var'),
        rep(2),
        i(3, '1'),
        i(4),
        i(5, '2'),
        i(6),
      }
    )
  ),
  s(
    {
      trig = 'mycs',
      dscr = 'case...esac',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myfunc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>() {
          <>
      }
      ]],
      {
        i(1, 'FuncName'),
        i(0, 'pass'),
      }
    )
  ),
  s(
    {
      trig = 'myfunc',
      dscr = 'function',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mymain',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #  NOTE: Main Functions
      function main() {
        <>
      }

      main
      ]],
      { i(1) }
    )
  ),
  s(
    {
      trig = 'mymain',
      dscr = 'Function Main',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myvar',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>=<>
      ]],
      {
        i(1, 'VarName'),
        i(2, 'VarValue'),
      }
    )
  ),
  s(
    {
      trig = 'myvar',
      dscr = 'Var',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mydefc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      # Color
      SkyBlue='\033[0;36m'
      Green='\033[0;32m'
      Plain='\033[0m'
      Red='\e[1;31m'
      Gray='\e[1;30m'
      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mydefc',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myif',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      if <> <> <> <><><> <>; then
          <>
      else
          <>
      fi
      ]],
      {
        t '[[',
        t '!',
        c(1, {
          sn(nil, { t '-d', i(1) }),
          sn(nil, { t '-f', i(1) }),
        }),
        t '"',
        i(2),
        t '"',
        t ']]',
        i(3),
        i(4),
      }
    )
  ),
  s(
    {
      trig = 'myif',
      dscr = 'if..fi',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myiif',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      if <> <> <>; then
        <>
      else
        <>
      fi
      ]],
      {
        t '[[',
        i(1),
        t ']]',
        i(2),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'myiif',
      dscr = 'if..else...fi',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myfor',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      for <> in <>${<>[@]}<>; do
          echo <>${<>}<>
      done
      ]],
      {
        i(1, 'element'),
        t '"',
        i(2, 'array'),
        t '"',
        t '"',
        rep(1),
        t '"',
      }
    )
  ),
  s(
    {
      trig = 'myfor',
      dscr = 'for...do...done',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myeof',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      sudo <> <> <<<<-EOF
      <><>
      <>EOF
      ]],
      {
        c(1, {
          sn(nil, { i(1, 'tee') }),
          sn(nil, { i(1, 'tee -a') }),
        }),
        i(2, 'file'),
        t '\t\t',
        i(0),
        t '\t\t',
      }
    )
  ),
  s(
    {
      trig = 'myeof',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

	    ]],
      {}
    )
  ),
  s(
    {
      trig = 'myread',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      read <> "<>" -e <>
      ]],
      {
        c(1, { t '-p', t '-s', t '-t' }),
        i(2, 'InfoText'),
        i(3, 'VarName'),
      }
    )
  ),
  s(
    {
      trig = 'myread',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mydate',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      $(date +"<>")
      ]],
      {
        c(1, { t '%F %T', t '%Y-%m-%d %H:%M' }),
      }
    )
  ),
  s(
    {
      trig = 'mydate',
      dscr = 'date',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mylibs',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      source /etc/profile.d/import_shell_libs.sh

      <>
      ]],
      { i(0) }
    )
  ),
  s(
    {
      trig = 'mylibs',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myps',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      push array <>
      ]],
      {
        i(1, 'addElement'),
      }
    )
  ),
  s(
    {
      trig = 'myps',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myecc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      echo -e "$<>"
      ]],
      {
        c(1, { t 'SkyBlue', t 'Plain', t 'Green' }),
      }
    )
  ),
  s(
    {
      trig = 'myecc',
      dscr = 'echo color',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myecho',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      echo "<>"
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myecho',
      dscr = 'echo',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myel',
      dscr = 'echo color',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myrps',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      repeat_str "<>" <>
      ]],
      {
        c(1, { t '*', t '-' }),
        i(2, 'num'),
      }
    )
  ),
  s(
    {
      trig = 'myrps',
      dscr = 'repeat_str',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myct',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      center -l <> "<>"
      ]],
      {
        i(1, 'num'),
        i(2, 'text'),
      }
    )
  ),
  s(
    {
      trig = 'myct',
      dscr = 'center',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mytd',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
	    #  <><> <>
	    ]],
      {
        c(1, { t 'NOTE', t 'TODO', t 'ISSUE' }),
        t ':',
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mytd',
      dscr = 'todo comment',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

	    ]],
      {}
    )
  ),
  s(
    {
      trig = 'mypff',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      printf "<>" <><><><>
      ]],
      {
        t '*%.0s',
        t '{',
        t '1..',
        i(1, 'endNum'),
        t '}',
      }
    )
  ),
  s(
    {
      trig = 'mypff',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mynt',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #  NOTE: <>
      ]],
      {
        i(i),
      }
    )
  ),
  s(
    {
      trig = 'mynt',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myans',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      printf "${YELLOW}%s"
      read -r -p "<>? [y/N]" -e answer
      printf "${RESET}%s"

      if <> "$answer" != y <> && <> "$answer" != Y <>; then
          <>
      else
          <>
      fi
      ]],
      {
        i(1, 'Have you already download python'),
        t '[[',
        t ']]',
        t '[[',
        t ']]',
        i(2, 'Install_1'),
        i(3, 'Install_2'),
      }
    )
  ),
  s(
    {
      trig = 'myans',
      dscr = 'answer',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mypf',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      printf "${<>}%s<>${RESET}\n" "<>"
      ]],
      {
        i(1, 'SKYBLUE'),
        i(2),
        i(3, 'text'),
      }
    )
  ),
  s(
    {
      trig = 'mypf',
      dscr = 'printf',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mydot',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      printf "${SKYBLUE}%s"
      printf "*%.0s" {1..<>}
      printf "${RESET}%s\n"
      ]],
      {
        i(1, '60'),
      }
    )
  ),
  s(
    {
      trig = 'mydot',
      dscr = 'dots',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myva',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>=${<>:=<>}
      ]],
      {
        i(1, 'VarName'),
        rep(1),
        i(2, 'VarValue'),
      }
    )
  ),
  s(
    {
      trig = 'myva',
      dscr = 'var',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mywl',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      while <> <> <> 0 <> do
          <>
      done
      ]],
      {
        t '[',
        i(1, '$#'),
        i(2, '-gt'),
        t '];',
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mywl',
      dscr = 'while',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myex',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      local <>="$HOME/<>"

      if <> -d "$<>" <>; then
          <>
      else
          <>
      fi
      ]],
      {
        i(1, 'target_dir'),
        i(2),
        t '[[',
        rep(1),
        t ']]',
        i(3, 'exies'),
        i(4, 'not exies'),
      }
    )
  ),
  s(
    {
      trig = 'mypac',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      sudo pacman -S --noconfirm "<><>"
      ]],
      {
        t '$',
        i(1, 'element'),
      }
    )
  ),
  s(
    {
      trig = 'mypac',
      dscr = 'dscr',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myit',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      installed=<>(sudo pacman -Qs "<><>")
      ]],
      {
        t '$',
        t '$',
        i(1, 'element'),
      }
    )
  ),
  s(
    {
      trig = 'myit',
      dscr = 'installed',
      regTrig = false,
      snippetType = 'snippet',
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
}
