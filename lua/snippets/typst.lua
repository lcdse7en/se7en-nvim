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

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
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
        i(1, 'purple'),
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
}
