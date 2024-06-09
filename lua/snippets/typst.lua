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
      <>text(fill: black, size: 12pt, font: <>, "<>")
      ]],
      {
        c(1, {
          sn(nil, {
            i(1, '#'),
          }),
          sn(nil, {
            i(1, ''),
          }),
        }),
        c(2, {
          sn(nil, {
            i(1, '""'),
          }),
          sn(nil, {
            i(1, '"STXinwei"'),
          }),
        }),
        i(3),
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
      #list(
        indent: <>em,
        body-indent: .6em,
        <><><>,
        <><><>,
      )
      ]],
      {
        i(1, '2'),
        t '[',
        i(2),
        t ']',
        t '[',
        i(3),
        t ']',
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
      #line(
        length: 100%,
        <>
      )
      <>
      ]],
      {
        c(1, {
          t 'stroke: 2pt + gradient.linear(..color.map.rainbow),',
          t 'stroke: (paint: blue, thickness: 1pt, dash: "dashed"),',
        }),
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
      <>mitext(`
        \begin{equation}
        \begin{aligned}
        借：& <> \\
            & <> \\
        贷：& <> \\
            & <> \\
        \end{aligned}
        \end{equation}
      `)
      ]],
      {
        c(1, {
          sn(nil, {
            i(1),
          }),
          sn(nil, {
            i(1, '#'),
          }),
        }),
        i(2),
        i(3),
        i(4),
        i(5),
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
        columns: (.1fr, 1fr, 1fr),
        gutter: 16pt,
        stack(
          spacing: 20pt,
          cvEntry(
            title: <><>,
            organisation: <><>,
            logo: "",
            date: <><>,
            location: <><>,
            description: "",
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
        t ']',
        t '[',
        t ']',
        t '[',
        t ']',
        t '[',
        t ']',
        t '[',
        i(1),
        t ']',
        t '[',
        t ']',
        t '[',
        t ']',
        i(2),
        t '[',
        t ']',
        t '[',
        i(3),
        t ']',
        t '[',
        t ']',
        t '[',
        t ']',
        t '""',
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
            (label: <>Column1Title<>, align: center, func:r =<> r.<>),
            (label: <>Column2Title<>, align: center, func:r =<> r.<>),
            (label: <>Column3Title<>, align: center, func:r =<> r.<>),
          ),
          fill: (_, row) =<> if calc.odd(row) { luma(240) } else if row == 0 { rgb(255, 218, 185) } else { luma(220) },
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
      trig = 'myul',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #underline(stroke: 1.2pt + red, offset: 3pt,)<><><>
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
      trig = 'myul',
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
      trig = 'myjf',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><> <>
      ]],
      {
        c(1, {
          sn(nil, {
            i(1, '& '),
          }),
          sn(nil, {
            i(1, '借：& '),
          }),
        }),
        i(2),
        t '\\\\',
      }
    )
  ),
  s(
    {
      trig = 'myjf',
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
      trig = 'mydf',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><> <>
      ]],
      {
        c(1, {
          sn(nil, {
            i(1, '& '),
          }),
          sn(nil, {
            i(1, '贷：& '),
          }),
        }),
        i(2),
        t '\\\\',
      }
    )
  ),
  s(
    {
      trig = 'mydf',
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
  s(
    {
      trig = 'mycas',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>
        <> cases(
             "<>",
             "<>",
           )
      <>
      ]],
      {
        t '$',
        i(1),
        i(2),
        i(3),
        t '$',
      }
    )
  ),
  s(
    {
      trig = 'mycas',
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
      trig = 'mypp',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pin(<>)<>
      ]],
      {
        i(1, '1'),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mypl',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pinit-line(stroke: 1.5pt + crimson, start-dy: -0.25em, end-dy: -0.25em, <>, <>)
      ]],
      {
        i(1, '1'),
        i(2, '2'),
      }
    )
  ),
  s(
    {
      trig = 'mypz',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pinit-highlight-equation-from((<>, <>), <>, height: 2em, pos: <>, <><>
        <>
      <>
      ]],
      {
        i(1, '1'),
        i(2, '2'),
        rep(2),
        c(3, { t 'top', t 'bottom' }),
        c(4, { t 'fill: rgb(150, 90, 170))', t 'fill: rgb(0, 180, 255))' }),
        t '[',
        i(5),
        t ']',
      }
    )
  ),
  s(
    {
      trig = 'myph',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pin(<>)<>#pin(<>)

      #pinit-highlight(<>, <>)
      ]],
      {
        i(1, '1'),
        i(3, 'Text'),
        i(2, '2'),
        rep(1),
        rep(2),
      }
    )
  ),
  s(
    {
      trig = 'mysj',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #h(2em)<>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mycls',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><>
      ]],
      {
        i(1, ' '),
        c(1, {
          t 'm-light-brown',
          t 'ovgu-red',
          t 'ovgu-purple',
          t 'ovgu-darkgray',
          t 'ovgu-orange',
          t 'seagreen',
          t 'indianred',
        }),
      }
    )
  ),
  s(
    {
      trig = 'myfai',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #fa-icon("<>", solid : true)
      ]],
      {
        c(1, {
          t 'chess-queen',
          t 'spider',
          t 'paw',
          t 'feather',
          t 'code-commit',
          t 'file-code',
          t 'bars',
          t 'circle-dot',
          t 'chart-simple',
          t 'check',
          t 'circle-check',
          t 'square-check',
          t 'xmark',
          t 'link',
          t 'signature',
        }),
      }
    )
  ),
  s(
    {
      trig = 'myqfw',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #d(<>)
      ]],
      {
        i(1, 'number'),
      }
    )
  ),
  s(
    {
      trig = 'mysp',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #sp.title_box(
        "<>",
        authors: "lcdse7en¹",
        institutes: "¹",
        keywords: "",
        image: rect(height: 6em, width: 100%)<>#set align(center+horizon);#image("../images/<>", width: 100%)<>,
      )

      #columns(2, <>
        #sp.column_box(heading: "")<>There is nothing here yet<>
        #sp.column_box()<>

        <>

        #colbreak()

        #sp.column_box(heading: "General Relativity", stretch_to_next: false)<>

        <>
      <>)

      // #sp._common_box(heading: [only heading])

      #sp.bottom_box()<>This is a box at the bottom<>
      ]],
      {
        i(1, 'title'),
        t '[',
        i(2, '1.png'),
        t ']',
        t '[',
        t '[',
        t ']',
        t '[',
        t ']',
        t '[',
        t ']',
        t ']',
        t '[',
        t ']',
      }
    )
  ),
  s(
    {
      trig = 'mylt',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #let <> = <>
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myft',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #let mydic = json("json/<>.json")
      #let v1 = mydic.values().at(0)
      #let arr = v1.zip(
        <>
      )

      #figure(
        caption: "",
        table(
          columns: <>,
          align: (<>),
          stroke: (_, y) <> (
            top: if y <> 1 {
              1pt
            } else {
              0pt
            },
            bottom: 1pt,
          ),
          table.header(..for k in mydic.keys() {
            (align(center)[#k,])
          }),
          ..for i in arr.flatten() {
            ([#i,])
          },
        ),
      )
      ]],
      {
        i(1, '1'),
        f(
          -- order is 2,1, not 1,2!!
          function(args, snip)
            local num = tonumber(args[1][1])

            local kuohao = ''
            for i = 1, num - 1 do
              kuohao = kuohao .. 'mydic.values().at(' .. i .. '),'
            end
            return kuohao
          end,
          { 2 }
        ),
        i(2, '3'),
        f(
          -- order is 2,1, not 1,2!!
          function(args, snip)
            local num = tonumber(args[1][1])

            local kuohao = ''
            for i = 1, num do
              kuohao = kuohao .. 'center, '
            end
            return kuohao
          end,
          { 2 }
        ),
        t '=>',
        t '<=',
      }
    )
  ),
  -- s(
  --   {
  --     trig = 'myft',
  --     regTrig = false,
  --     snippetType = 'autosnippet',
  --     priority = 2000,
  --   },
  --   fmta(
  --     [[
  --     #let count = <>
  --     #let id = range(1, count+1)
  --
  --     #let <> = (
  --       "",
  --       "",
  --       "",
  --     )
  --     #let <> = (
  --       "",
  --       "",
  --       "",
  --     )
  --     #let <> = (
  --       "",
  --       "",
  --       "",
  --     )
  --
  --     #let array = (id.zip(<>, <>, <>))
  --
  --     #figure(
  --       table(
  --         stroke: 1pt + black,
  --         columns: <>,
  --         align: center+ horizon,
  --         <>
  --         ..for x in array {(
  --           ..for y in x {(
  --             [#y],
  --           )}
  --         )}
  --       ),
  --       caption: [],
  --     )
  --     ]],
  --     {
  --       i(1, '7'),
  --       i(2, 'array_a'),
  --       i(3, 'array_b'),
  --       i(4, 'array_c'),
  --       rep(2),
  --       rep(3),
  --       rep(4),
  --       i(5, '4'),
  --       f(
  --         -- order is 2,1, not 1,2!!
  --         function(args, snip)
  --           local num = tonumber(args[1][1])
  --
  --           local kuohao = ''
  --           for i = 1, num do
  --             kuohao = kuohao .. '[]'
  --           end
  --           return 'table.header' .. kuohao .. ','
  --         end,
  --         { 5 }
  --       ),
  --     }
  --   )
  -- ),
  s(
    {
      trig = 'myfi',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #figure(
        image("<>", width: 2cm),
        caption: [<>]
      ) <><><>
      ]],
      {
        i(1),
        i(2),
        t '<',
        i(3),
        t '>',
      }
    )
  ),
  s(
    {
      trig = 'myacr',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #acr("<>")<>
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myfn',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #footnote[<>]<>
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mysup',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #super("<>")<>
      ]],
      {
        i(1, '1'),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mystr',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      stroke: (x: none),<>
      ]],
      {
        i(0),
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
      align: (x, _) <>
        if x == 0 { center } else { left },
      <>
      ]],
      {
        t '=>',
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myrows',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      table.cell(rowspan: <>, align: center+horizon)[<>]<>
      ]],
      {
        i(1, '2'),
        i(2),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myfc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #figure(
        sourcecode()[
          ```<>
          <>
          ```
        ],
        caption: "<>"
      )
      ]],
      {
        i(1, typst),
        i(3),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myfb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #figure(
        caption: "<>",
      )[
        ```<>
        <>
        ```
      ]
      ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'mycd',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #code(
        lang: "<>",
        numbering: false,
        line-offset: -2pt,
        ```<>
        <>
        ```,
      );#blank_par
      ]],
      {
        rep(1),
        i(1, 'typst'),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myxkh',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><><>
      ]],
      {
        t '（',
        i(1),
        t '）',
      }
    )
  ),
  s(
    {
      trig = 'myfkh',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><><>
      ]],
      {
        t '「',
        i(1),
        t '」',
      }
    )
  ),
  s(
    {
      trig = 'mypt',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #pro-tip[
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
      trig = 'mytm',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #term("<>")
      ]],
      {
        i(1, 'code mode'),
      }
    )
  ),
  s(
    {
      trig = 'myfe',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      #figure(
        caption: "<>",
        kind: math.equation,
        $
          <>
        $,
      )
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
}
