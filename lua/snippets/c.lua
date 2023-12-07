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
    {
      trig = "mymain",
      regTrig = false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
      int main ()
      {
        <>

        exit(0);
      }
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "mymain",
      dscr = "int main",
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
      trig = "myinc",
      regTrig = false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
      #include <><><>
      ]],
      {
        t "<",
        i(1),
        t ">",
      }
    )
  ),
  s(
    {
      trig = "myinc",
      dscr = "include",
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
      trig = "pf",
      regTrig = false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
      printf(<>);
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "pf",
      dscr = "printf",
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
