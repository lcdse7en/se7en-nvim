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
    { trig = 'h1', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      # <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    { trig = 'h2', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      ## <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    { trig = 'h3', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      ### <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    { trig = 'h4', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      #### <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    { trig = 'mylink', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      [<>](<>)
      ]],
      {
        i(1, 'desc'),
        i(2, 'net'),
      }
    )
  ),
  s(
    { trig = 'mylink', snippetType = 'snippet' },
    fmta(
      [[
      [<>](<>)
      ]],
      {
        i(1, 'desc'),
        i(2, 'net'),
      }
    )
  ),
  s(
    { trig = 'mycb', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      ```<>
      <>
      ```
      ]],
      {
        c(1, { t 'python', t 'shell', t 'latex' }),
        i(2),
      }
    )
  ),
  s(
    { trig = 'mycb', snippetType = 'snippet' },
    fmta(
      [[
      ```<>
      <>
      ```
      ]],
      {
        c(1, { t 'python', t 'shell', t 'latex' }),
        i(2),
      }
    )
  ),
  s(
    { trig = 'mycl', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      `<>`
      ]],
      {
        i(1, 'code'),
      }
    )
  ),
  s(
    { trig = 'mycl', snippetType = 'snippet' },
    fmta(
      [[
      `<>`
      ]],
      {
        i(1, 'code'),
      }
    )
  ),
  s(
    { trig = 'myimg', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      ![<>](<>.<> =400x400)
      ]],
      {
        i(1, 'alt text'),
        i(2, 'image'),
        c(3, { t 'png', t 'jpg', t 'jpeg' }),
      }
    )
  ),
  s(
    { trig = 'myimg', snippetType = 'snippet' },
    fmta(
      [[
      ![<>](<>.<> =400x400)
      ]],
      {
        i(1, 'alt text'),
        i(2, 'image'),
        c(3, { t 'png', t 'jpg', t 'jpeg' }),
      }
    )
  ),
  s(
    {
      trig = 'myhimg',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>div align="center"<>
          <>img src="<>"<>
      <>/div<>
      ]],
      {
        t '<',
        t '>',
        t '<',
        i(1, 'path'),
        t '>',
        t '<',
        t '>',
      }
    )
  ),
  s(
    {
      trig = 'myhimg',
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
    { trig = 'mytodo', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      - [<>] <>
      ]],
      {
        c(1, { t 'x', t ' ' }),
        i(2, ''),
      }
    )
  ),
  s(
    { trig = 'mytodo', snippetType = 'snippet' },
    fmta(
      [[
      - [<>] <>
      ]],
      {
        c(1, { t 'x', t ' ' }),
        i(2, ''),
      }
    )
  ),
  s(
    { trig = 'mybd', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      **<>**
      ]],
      {
        i(1, 'textbold'),
      }
    )
  ),
  s(
    { trig = 'mybd', snippetType = 'snippet' },
    fmta(
      [[
      **<>**
      ]],
      {
        i(1, 'boldtext'),
      }
    )
  ),
  s(
    { trig = 'myit', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      *<>*
      ]],
      {
        i(1, 'textit'),
      }
    )
  ),
  s(
    { trig = 'myit', snippetType = 'snippet' },
    fmta(
      [[
      *<>*
      ]],
      {
        i(1, 'textit'),
      }
    )
  ),
  s(
    {
      trig = 'mybq',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><><><><><><>
      ]],
      {
        t '<',
        i(1),
        t '>',
        i(2),
        t '</',
        rep(1),
        t '>',
      }
    )
  ),
  s(
    {
      trig = 'mybq',
      dscr = 'biaoqian',
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
      trig = 'mykbd',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>kbd<><><>kbd<>
      ]],
      {
        t '<',
        t '>',
        i(1),
        t '</',
        t '>',
      }
    )
  ),
  s(
    {
      trig = 'mykbd',
      dscr = 'kbd html',
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
      trig = 'mymk',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>mark<><><>mark<>
      ]],
      {
        t '<',
        t '>',
        i(1),
        t '</',
        t '>',
      }
    )
  ),
  s(
    {
      trig = 'mymk',
      dscr = 'mark html',
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
      trig = 'mytb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      :<>:
      ]],
      {
        c(1, { t 'bulb', t 'memo', t 'white_check_mark', t '100', t 'warning', t 'joy' }),
      }
    )
  ),
  s(
    {
      trig = 'mytb',
      dscr = 'ziti tubiao',
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
