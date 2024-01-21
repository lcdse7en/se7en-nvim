--*******************************************
-- Author:      lcdse7en                    *
-- E-mail:      2353442022@qq.com           *
-- Date:        2023-05-12                  *
-- Description:                             *
--*******************************************
local ls = require 'luasnip'
local s = ls.snippet
local c = ls.choice_node
local sn = ls.snippet_node
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local line_begin = require('luasnip.extras.expand_conditions').line_begin
-- local tex = require "utils.latex"
local util = require 'luasnip.util.util'
local node_util = require 'luasnip.nodes.util'
local ai = require 'luasnip.nodes.absolute_indexer'
local m = require('luasnip.extras').match

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

table_node = function(args)
  local tabs = {}
  local count
  table = args[1][1]:gsub('%s', ''):gsub('|', '')
  count = table:len()
  for j = 1, count do
    local iNode
    iNode = i(j)
    tabs[2 * j - 1] = iNode
    if j ~= count then
      tabs[2 * j] = t ' & '
    end
  end
  return sn(nil, tabs)
end

rec_table = function()
  return sn(nil, {
    c(1, {
      t { '' },
      sn(nil, { t { '\\\\', '' }, d(1, table_node, { ai[1] }), d(2, rec_table, { ai[1] }) }),
    }),
  })
end
-- item

local rec_ls
rec_ls = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t '',
      sn(nil, { t { '', '\t\\item ' }, i(1), d(2, rec_ls, {}) }),
    })
  )
end

return {
  s(
    {
      trig = 'myip',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #import "<>": <>
      ]],
      {
        i(1, 'package'),
        i(2, '*'),
      }
    )
  ),
  s(
    {
      trig = 'myip',
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
      trig = 'h1',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      = <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'h2',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      == <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'h3',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      === <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'h4',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      === <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myfig',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #figure(
        image("<>"),
        caption: [<>],
      )
      ]],
      {
        i(1, 'img_path'),
        i(2, 'capInfo'),
      }
    )
  ),
  s(
    {
      trig = 'myfig',
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
      trig = 'myrb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #ruby[<>][<>]
      ]],
      {
        i(1, 'uptext'),
        i(2, 'downtext'),
      }
    )
  ),
  s(
    {
      trig = 'myrb',
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
      trig = 'mysc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #sourcecode(
        )[
      ```<>
      <>
      ```
      ]
      <>
      ]],
      {
        c(1, {
          sn(nil, {
            i(1),
          }),
          sn(nil, {
            i(1, 'typst'),
          }),
        }),
        i(2),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mysc',
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
      trig = 'mylink',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #link("<>")[<>]
      ]],
      {
        i(1, 'www.baidu.com'),
        i(2, 'baidu'),
      }
    )
  ),
  s(
    {
      trig = 'mylink',
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
      trig = 'mytt',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #text(fill: <>)[<>]
      ]],
      {
        c(1, {
          sn(nil, {
            i(1, 'purple.lighten(20%)'),
          }),
          sn(nil, {
            i(1, 'indianred'),
          }),
        }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mytt',
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
      trig = 'h3',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      === <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'h3',
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
      trig = 'h4',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      ==== <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'h4',
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
      trig = 'myewm',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #qrcode("<>")
      ]],
      {
        i(1, 'https://github.com/lcdse7en'),
      }
    )
  ),
  s(
    {
      trig = 'myewm',
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
      trig = 'mytd',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        #todo[<>]
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'mytd',
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
      // <> <>
      ]],
      {
        c(1, {
          sn(nil, {
            i(1, 'TODO'),
          }),
          sn(nil, {
            i(1, 'NOTE'),
          }),
        }),
        i(2),
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
      trig = 'mypb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pagebreak()
      <>
      ]],
      {
        i(0),
      }
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
      + <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myit',
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
      trig = 'mycb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        // =================================================
        // <>
        // =================================================
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myali',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #align(center)[
        <>
      ]
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myali',
      dscr = 'align',
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
      trig = 'myimg',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #image("<>", width: <><>)
      ]],
      {
        i(1, 'image.jpg'),
        i(2),
        t '%',
      }
    )
  ),
  s(
    {
      trig = 'myimg',
      dscr = 'image',
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
      trig = 'mypk',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pagebreak()
      <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mypk',
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
      trig = 'myen',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        + <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myen',
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
      trig = 'mylis',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      - <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mylis',
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
      trig = 'mylin',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #line(length: <>%)
      <>
      ]],
      {
        i(1, '100'),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mylin',
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
      trig = 'mybox',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        #box(inset: (x: 0.3em), outset: (y: 0.3em), fill: <>, radius: 3pt, "<>")
      ]],
      {
        c(1, {
          sn(nil, {
            i(1, 'red'),
          }),
          sn(nil, {
            i(1, 'gray.lighten(60%)'),
          }),
        }),
        i(2, 'text'),
      }
    )
  ),
  s(
    {
      trig = 'mybox',
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
      trig = 'myfl',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #mitext(`
        \begin{equation}
        \begin{aligned}
        借：& <> \\
        贷：& <> \\
        \end{aligned}
        \end{equation}
      `)
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myfl',
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
      trig = 'myhl',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #highlight(
        "<>",
        <>,
      )
      ]],
      {
        i(1, 'text'),
        c(2, {
          sn(nil, {
            i(1, 'red'),
          }),
          sn(nil, {
            i(1, 'yellow'),
          }),
          sn(nil, {
            i(1, 'gray.lighten(50%)'),
          }),
        }),
      }
    )
  ),
  s(
    {
      trig = 'myhl',
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
      trig = 'mygri',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #grid(
        columns: (50%, 50%),
        gutter: 16pt,
        stack(
          spacing: 20pt,
          cvEntry(
            title: <><>,
            organisation: <><><>,
            logo: "",
            date: <><>,
            location: <><>,
            description: <>,
            tags: (""),
          ),
        ),stack(
          spacing: 20pt,
          cvEntry(
            title: <><>,
            organisation: <><><>,
            logo: "",
            date: <><>,
            location: <><>,
            description: <>,
            tags: (""),
          ),
        )
      )
      ]],
      {
        t '[',
        t ']',
        t '[',
        i(2),
        t ']',
        t '[',
        t ']',
        t '[',
        t ']',
        c(1, {
          sn(nil, {
            t '$ ',
            i(1),
            t ' $',
          }),
          sn(nil, {
            i(1, ''),
          }),
        }),
        t '[',
        t ']',
        t '[',
        i(4),
        t ']',
        t '[',
        t ']',
        t '[',
        t ']',
        c(3, {
          sn(nil, {
            t '$ ',
            i(1),
            t ' $',
          }),
          sn(nil, {
            i(1, ''),
          }),
        }),
      }
    )
  ),
  s(
    {
      trig = 'mygri',
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
      trig = 'mypar',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #par(
        first-line-indent: 2em,
        <><><>,
      )
      ]],
      {
        t '[',
        i(1),
        t ']',
      }
    )
  ),
  s(
    {
      trig = 'mypar',
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
      trig = 'myjh',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>
      ]],
      {
        i(0, ''),
      }
    )
  ),
  s(
    {
      trig = 'myjh',
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
      trig = 'mysb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #showybox(
        title: "<>",
        frame: (
          border-color: blue,
          title-color: blue.lighten(30%),
          body-color: blue.lighten(95%),
          footer-color: blue.lighten(80%),
        ),
      )<>
        <>
      <>
      ]],
      {
        i(1),
        t '[',
        i(0),
        t ']',
      }
    )
  ),
  s(
    {
      trig = 'mysb',
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
      trig = 'myrec',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #rect(
        width: 100%,
        radius: 10%,
        stroke: 0.5pt,
        fill: yellow.lighten(60%),
      )<>
        <>
      <>
      ]],
      {
        t '[',
        i(0),
        t ']',
      }
    )
  ),
  s(
    {
      trig = 'myrec',
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
      trig = 'mytabut',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #let <> = (
        (<>: "<>", <>: <>, <>: <>),
        (<>: "<>", <>: <>, <>: <>),
        (<>: "<>", <>: <>, <>: <>),
      )

      #align(center)<>
        #tabut(
          <>.sorted(key: r =<> r.total).rev(),
          (
            (label: <>ID<>, align: center, func:r =<> r._index +1 ),
            (label: <>Column1Title<>, align: right, func:r =<> r.<>),
            (label: <>Column2Title<>, align: right, func:r =<> r.<>),
            (label: <>Column3Title<>, align: right, func:r =<> r.<>),
          ),
          fill: (_, row) =<> if calc.odd(row) { luma(240) } else if row == 0 { rgb(146, 41, 57) } else { luma(220) },
          stroke : none,
        )
      <>
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        rep(2),
        i(8),
        rep(4),
        i(9),
        rep(6),
        i(10),
        rep(2),
        i(11),
        rep(4),
        i(12),
        rep(6),
        i(13),
        t '[',
        rep(1),
        t '>',
        t '[',
        t ']',
        t '>',
        t '[',
        t ']',
        t '>',
        rep(2),
        t '[',
        t ']',
        t '>',
        rep(4),
        t '[',
        t ']',
        t '>',
        rep(6),
        t '>',
        t ']',
      }
    )
  ),
  s(
    {
      trig = 'mytabut',
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
      trig = 'myrd',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      calc.round(<>, digits: 2)
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myrd',
      dscr = 'calc.round',
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
      trig = 'myls',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><><>
      <>
      <>
      <>
      ]],
      {
        t '\\begin{tabular}{',
        i(1, '0'),
        t { '}', '' },
        d(2, table_node, { 1 }, {}),
        d(3, rec_table, { 1 }),
        t { '', '\\end{tabular}' },
      }
    )
  ),
}
