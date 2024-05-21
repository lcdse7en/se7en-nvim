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
      trig = 'mywd',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      "<>": ["<>", "<>", "<>", "<>"],<>
      ]],
      {
        i(1, 'en'),
        rep(1),
        i(2, 'cn'),
        i(3, 'kr'),
        i(4, 'jp'),
        i(0),
      }
    )
  ),
}
