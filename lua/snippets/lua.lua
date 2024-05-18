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
    { trig = 'fmta', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
        s(
          {
            trig = "<>",
            regTrig=false,
            snippetType = "autosnippet",
            priority = 2000,
          },
          fmta(
            <>
            <>
            <>,
            {
              <>
            }
          )
        ),
      ]],
      {
        i(1, 'key'),
        t '[[',
        i(2),
        t ']]',
        i(0),
      }
    )
  ),
  s(
    { trig = 'fmta', snippetType = 'snippet' },
    fmta(
      [[
        s(
          { trig = "<>", dscr = "format text", regTrig=false, snippetType = "autosnippet", priority = 2000, },
          fmta(
            <>
            <>
            <>,
            {
              i(1, "<>"),
            }
          )
        ),
      ]],
      {
        i(1, 'key'),
        t '[[',
        i(2, 'data'),
        t ']]',
        i(3, 'test'),
      }
    )
  ),
  s(
    { trig = 'fmts', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
        s(
          {
            trig = "<>",
            dscr = "<>",
            regTrig=false,
            snippetType = "snippet",
          },
          fmta(
            <>
            <>
            <>,
            {
              <>
            }
          )
        ),
      ]],
      {
        i(1, 'key'),
        i(2, 'dscr'),
        t '[[',
        i(3),
        t ']]',
        i(4),
      }
    )
  ),
  s(
    { trig = 'fmts', dscr = 'dscr', regTrig = false, snippetType = 'snippet' },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'myin',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>
      ]],
      {
        c(1, {
          sn(nil, {
            t 'i(',
            i(1, '1'),
            t '),',
          }),
          sn(nil, {
            t 'i(',
            i(1, '1'),
            t ',"',
            i(2, 'text'),
            t '"),',
          }),
        }),
      }
    )
  ),
  s(
    {
      trig = 'myin',
      dscr = 'insert_node',
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
    { trig = 'mycn', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
              c(<>, { t "<>", t"<>", t "<>"}),
      ]],
      {
        i(1, 'id'),
        i(2, 'text1'),
        i(3, 'text2'),
        i(4, 'text3'),
      }
    )
  ),
  s(
    { trig = 'mycn', snippetType = 'snippet' },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    { trig = 'myref', snippetType = 'autosnippet', priority = 2000 },
    c(1, { sn(nil, { t '"$', i(1), t '"' }), sn(nil, { t '"${', i(1), t '}"' }) })
  ),
  s(
    {
      trig = 'myref',
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
      trig = 'myuse',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        {
          "<>/<>",
          <>
        },
      ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
  s(
    { trig = 'myuse1', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
          use { "<>/<>", config = "require('plugins.<>')", }
      ]],
      {
        i(1, 'author'),
        i(2, 'package'),
        i(3, 'conf'),
      }
    )
  ),
  s(
    { trig = 'myuse', snippetType = 'snippet' },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    { trig = 'myzw', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      <><>
      ]],
      {
        t '<>',
        i(1, ''),
      }
    )
  ),
  s(
    { trig = 'mysn', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
          c(<>, {
            sn(nil, {
              <>
            }),
            sn(nil, {
              <>
            }),
          }),
      ]],
      {
        i(1, '1'),
        i(2),
        i(3),
      }
    )
  ),
  s(
    { trig = 'mypc', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      local status_ok, <> = pcall(require, "<>")
      if not status_ok then
        vim.notify "<> not found"
        return
      end

      <>.setup {
        <>
      }
      ]],
      {
        f(function(import_name)
          local parts = vim.split(import_name[1][1], '.', true)
          return parts[#parts] or ''
        end, { 1 }),
        i(1),
        f(function(import_name)
          local parts = vim.split(import_name[1][1], '.', true)
          return parts[#parts] or ''
        end, { 1 }),
        f(function(import_name)
          local parts = vim.split(import_name[1][1], '.', true)
          return parts[#parts] or ''
        end, { 1 }),
        i(0, '--config'),
      }
    )
  ),
  s(
    {
      trig = 'mypc',
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
    { trig = 'mynote', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      --  <>: <>
      ]],
      {
        c(1, { t 'NOTE', t 'TODO', t 'WARN', t 'FIX', t 'HACK', t 'PERF' }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mytuse',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>
      ]],
      {
        c(1, {
          sn(nil, {
            t '\\usepackage{',
            i(1),
            t '}',
          }),
          sn(nil, {
            t '\\usepackage[',
            i(1),
            t ']',
            t '{',
            i(2),
            t '}',
          }),
        }),
      }
    )
  ),
  s(
    {
      trig = 'mytuse',
      dscr = 'LaTex usepackage',
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
      trig = 'myconf',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      config = function()
        <>
      end,
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myconf',
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
      trig = 'mydep',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      dependencies = {
        "<>/<>",
        "<>/<>",
        "<>/<>",
        "<>/<>",
      },
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(8),
      }
    )
  ),
  s(
    {
      trig = 'mydep',
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
      trig = 'myks',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      keys = {
        { "<><>", "<>", desc = "<>"},
        { "<><>", "<>", desc = "<>"},
      },
      <>
      ]],
      {
        t '<leader>',
        i(1),
        i(2, 'cmd'),
        i(3, 'desc'),
        t '<leader>',
        i(4),
        i(5, 'cmd'),
        i(6, 'desc'),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myncc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      vim.api.nvim_create_autocmd({ "<>" }, {
        <>
      })
      ]],
      {
        i(1, 'event'),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myncc',
      regTrig = false,
      snippetType = 'snippet',
      priority = 2000,
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mynca',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      group = vim.api.nvim_create_augroup("<>", { clear = true }),
      <>
      ]],
      {
        i(1, 'groupName'),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mynca',
      regTrig = false,
      snippetType = 'snippet',
      priority = 2000,
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
      callback = function()
        <>
      end,
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'mycb',
      regTrig = false,
      snippetType = 'snippet',
      priority = 2000,
    },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mybsi',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      ["<>"] = "https://<>",
      ]],
      {
        i(1, 'name'),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mybsi',
      dscr = 'browser link',
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
      trig = 'mybsc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
			--  NOTE: <>
	    ["<>"] = {
			  ["name"] = "<>",
				<>
			},
	    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),
  s(
    {
      trig = 'mybsc',
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
      trig = 'mybss',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
	    --  NOTE: <>
			["<>"] = "<>",
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
      trig = 'mybss',
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
      trig = 'myeve',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      event = "<>",
      ]],
      {
        i(1, 'VeryLazy'),
      }
    )
  ),
  s(
    {
      trig = 'myeve',
      dscr = 'event',
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
      --  <>: <>
      ]],
      {
        c(1, { t 'NOTE', t 'TODO', t 'ISSUE' }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mytd',
      dscr = 'TODO',
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
      trig = 'myreq',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      local <> = require "<>"
      ]],
      {
        f(function(import_name)
          local parts = vim.split(import_name[1][1], '.', true)
          return parts[#parts] or ''
        end, { 1 }),
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myreq',
      dscr = 'local require',
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
      enabled = <>,
      ]],
      {
        i(1, 'false'),
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
      trig = 'myrn',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      return {
        '<>/<>',
        enabled = true,
        config = function()
          local <> = require('<>')
          <>.setup {
            <>
          }
        end
      }
      ]],
      {
        i(1, 'gitName'),
        i(2),
        i(3),
        f(function(import_name)
          local parts = vim.split(import_name[1][1], '.', true)
          return parts[1] or ''
        end, { 2 }),
        f(function(import_name)
          local parts = vim.split(import_name[1][1], '.', true)
          return parts[1] or ''
        end, { 3 }),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myrn',
      dscr = 'return',
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
      trig = 'mycob',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      -- ============================================================
      -- <>
      -- ============================================================
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mycob',
      dscr = 'comment-box',
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
      <> <>
      ]],
      {
        t '',
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myjh',
      dscr = 'jiahao symbol',
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
      trig = 'myrep',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        f(function(import_name)
          local parts = vim.split(import_name[1][1], ".", true)
          return parts[<>] or ""
        end, { 1 }),
        <>
      ]],
      {
        c(1, {
          sn(nil, {
            i(1, '#parts'),
          }),
          sn(nil, {
            i(1, '1'),
          }),
        }),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myip',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        local <> = { "<>", "<>" }

        for _, k in ipairs(<>) do
          <>
        end
      ]],
      {
        i(1, 'tables'),
        i(2, 'var1'),
        i(3, 'var2'),
        rep(1),
        i(0),
      }
    )
  ),
  s(
    {
      trig = '<',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><><>
      ]],
      {
        t '<',
        i(1),
        t '>',
      }
    )
  ),
}
