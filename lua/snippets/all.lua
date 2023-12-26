local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local conds = require 'luasnip.extras.expand_conditions'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

local get_visual = function(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s('choicenode', c(1, { t 'choice 1', t 'choice 2', t 'choice 3' })),
  s(
    'date',
    f(function()
      return os.date '%D - %H:%M'
    end)
  ),
  s(
    { trig = 'my}', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      {<>}
      ]],
      {
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    { trig = 'my)', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      (<>)
      ]],
      {
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    { trig = 'my]', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      [<>]
      ]],
      {
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    { trig = "my'", snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      "<>"
      ]],
      {
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    {
      trig = 'myghp',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      https://github.com/lcdse7en/<>
      ]],
      {
        i(1, 'repo'),
      }
    )
  ),
  s(
    {
      trig = 'myghp',
      dscr = 'lcdse7en',
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
      trig = 'mygit',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      git clone git@github.com:lcdse7en/<>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mygit',
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
}
