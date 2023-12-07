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
local c = ls.choice_node
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
      trig = "mysrt",
      regTrig = false,
      snippetType = "autosnippet",
      priority = 2000,
    },
    fmta(
      [[
      <>
      00:0<>:<><>,100 <> 00:0<>:<><>,100
      <>
      <>
      ]],
      {
        i(1, "1"),
        c(2, { t "0", t "1", t "2", t "3", t "4" }),
        i(3, "0"),
        i(4, "0"),
        t "-->",
        c(5, { t "0", t "1", t "2", t "3", t "4" }),
        i(6, "0"),
        i(7, "0"),
        i(8, "text"),
        t "",
      }
    )
  ),
  s(
    {
      trig = "mysrt",
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
