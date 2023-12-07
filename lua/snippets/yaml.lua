--*******************************************
-- Author:      se7enlcd                    *
-- E-mail:      2353442022@qq.com           *
-- create_Time: 2023-06-07                  *
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
    { trig = "mysmug", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      session: <>

      root: /home/se7en/.config/smug

      windows:
        - name: <>
          root: <>
          commands:
            - clear
            - <>
          panes:
            - type: <>
              commands:
                - clear
                - <>
      ]],
      {
        i(1, "prefix"),
        rep(1),
        rep(1),
        i(2, "cmd"),
        c(3, { t "horizontal", t "vertical" }),
        i(4, "cmd"),
      }
    )
  ),
  s(
    { trig = "mypa", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      panes:
        - type: <>
          commands:
            - clear
            - <>
      ]],
      {
        c(1, { t "horizontal", t "vertical" }),
        i(2, "cmd"),
      }
    )
  ),
  s(
    { trig = "mytype", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      - type: <>
      ]],
      {
        c(1, { t "horizontal", t "vertical" }),
      }
    )
  ),
  s(
    { trig = "mycmd", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      commands:
        - clera
        - <>
      ]],
      {
        i(1, "cmd"),
      }
    )
  ),
  s(
    { trig = "mycl", snippetType = "autosnippet", priority = 2000 },
    fmta(
      [[
      - clear
      - <>
      ]],
      {
        i(1, "cmd"),
      }
    )
  ),
}
