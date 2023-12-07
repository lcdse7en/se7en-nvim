--*******************************************
-- Author:      lcdse7en                    *
-- E-mail:      2353442022@qq.com           *
-- Date:        2023-05-12                  *
-- Description:                             *
--*******************************************
local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
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
    { trig = "ifmain", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      if __name__ == "__main__":
          <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "ifmain",
      dscr = "ifmain",
      regTrig = false,
      snippetType = "snippet",
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    { trig = "pt", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      print(<>)
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = "myeq", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      eq = Eq(<>, <>)
      pprint(eq)
      <>
      ]],
      {
        i(1, "EqLeft"),
        i(2, "EqRight"),
        i(0),
      }
    )
  ),
  s(
    { trig = "mydef", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      def <>(<>):
          pass
      ]],
      {
        i(1, ""),
        i(2, ""),
      }
    )
  ),
  s(
    { trig = "myfor", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      for i in range(<>):
          <>
      ]],
      {
        i(1, ""),
        i(2, ""),
      }
    )
  ),
  s(
    { trig = "mynote", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      #  <>: <>
      ]],
      {
        c(1, { t "NOTE", t "TODO", t "WARN", t "FIX", t "HACK", t "PERF" }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "mywo",
      regTrig = false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
      with open(file="<>", mode="<>", encoding="utf-8") as f:
          f.write(<>)
      ]],
      {
        i(1, "filepath"),
        c(2, { t "w+", t "r", t "wb+" }),
        i(3, "str"),
      }
    )
  ),
  s(
    {
      trig = "mywo",
      dscr = "with open",
      regTrig = false,
      snippetType = "snippet",
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = "mytd",
      regTrig = false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
      #  NOTE: <>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "mytd",
      dscr = "dscr",
      regTrig = false,
      snippetType = "snippet",
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
}
