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
local c = ls.choice_node
local r = ls.restore_node
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
-- generating function
local mat = function(args, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. 'x1', i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t ' & ')
      table.insert(nodes, r(ins_indx, tostring(j) .. 'x' .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t { ' \\\\', '' })
  end
  -- fix last node.
  nodes[#nodes] = t ' \\\\'
  return sn(nil, nodes)
end

return {
  s(
    { trig = 'mychoi', snippetType = 'autosnippet', priority = 2000 },
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
    { trig = 'mytp', snippetType = 'autosnippet' },
    fmta(
      [[
      \begin{tikzpicture}<>
        <>
      \end{tikzpicture}
      ]],
      {
        c(1, { t '[overlay,remember picture,>=stealth,nodes={align=left,inner ysep=1pt},<-]', t '' }),
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = 'mytm', snippetType = 'autosnippet' },
    fmta(
      [[
      \tikzmarknode{<>}{<>}
      ]],
      {
        i(1, 'markname'),
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    { trig = 'myhlm', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \hlmath{<>}{<>}
      ]],
      {
        i(1, 'red'),
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    { trig = 'myld', snippetType = 'autosnippet', dscr = 'Left down annotate' },
    fmta(
      [[
      \path (<>.south) ++ (0,-0.8em) node[anchor=north east,color=<>!67] (<>_node){<>};
      \draw [color=<>!57](<>.south) |- ([xshift=-0.3ex,color=<>]<>_node.south west);
      ]],
      {
        i(1, 'markname'),
        i(2, 'color'),
        rep(1),
        i(3, 'text'),
        rep(2),
        rep(1),
        rep(2),
        rep(1),
      }
    )
  ),
  s(
    { trig = 'mylu', snippetType = 'autosnippet', dscr = 'Left up annotate' },
    fmta(
      [[
      \path (<>.north) ++ (0,1em) node[anchor=south east,color=<>!67] (<>_node){<>};
      \draw [color=<>!57](<>.north) |- ([xshift=-0.3ex,color=<>]<>_node.south west);
      ]],
      {
        i(1, 'markname'),
        i(2, 'color'),
        rep(1),
        i(3, 'text'),
        rep(2),
        rep(1),
        rep(2),
        rep(1),
      }
    )
  ),
  s(
    { trig = 'myrd', snippetType = 'autosnippet', dscr = 'Right down annotate' },
    fmta(
      [[
      \path (<>.south) ++ (0,-0.8em) node[anchor=north west,color=<>!67] (<>_node){<>};
      \draw [color=<>!57](<>.south) |- ([xshift=-0.3ex,color=<>]<>_node.south east);
      ]],
      {
        i(1, 'markname'),
        i(2, 'color'),
        rep(1),
        i(3, 'text'),
        rep(2),
        rep(1),
        rep(2),
        rep(1),
      }
    )
  ),
  s(
    { trig = 'myhlt', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \hltext{<>}{<>}
      ]],
      {
        i(1, 'red'),
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    { trig = 'mymb', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \mbox{<>}
      ]],
      {
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    { trig = 'mytc', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \textcolor{<>}{<>}
      ]],
      {
        c(1, { t 'mychinarose', t 'Teal', t 'DarkOliveGreen', t 'DarkMagenta', t 'DarkSeaGreen', t 'SeaGreen' }),
        f(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      }
    )
  ),
  s(
    {
      trig = 'mytc',
      dscr = 'textcolor',
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
      trig = 'mybf',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \textbf{\kaiti <>}
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
      trig = 'mybf',
      dscr = 'textbf',
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
    { trig = 'mylongtb', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \begin{longtblr}[
          caption = {<>},
          entry = {<>},
          label = {tab:tab},
          % note{} = {}
      ]{
          width = 0.99\linewidth,
          colspec = {<>},
          % head = 1,
          hlines = {0.4pt},
          hline{1,2,Z} = {1.5pt},
          row{1} = {c},
          row{odd} = {bg=mypink},
          % row{even} = {bg=mypink},
          row{1} = {bg=myteal},
          % cell{2}{1} = {fg=red, bg=gray, font=\kaiti},
          % cell{2}{1} = {r=1, c=3}{l},
        }
        <> & <> & <> & <> \\
        text1 & text2 & text3 & text4
      \end{longtblr}
      ]],
      {
        c(1, { t '标题', t '' }),
        rep(1),
        c(2, { t '|X[l,1]|X[l,2]|X[l,2]|X[l,2]|', t '' }),
        i(3, 'column1'),
        i(4, 'column2'),
        i(5, 'column3'),
        i(6, 'column4'),
      }
    )
  ),
  s(
    { trig = 'mydyh', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      $\textgreater$<>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mydyh',
      dscr = 'dayuhao',
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
    { trig = 'myxyh', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      $\textless$<>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myxyh',
      dscr = 'xiaoyuhao',
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
    { trig = 'myflushr', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \begin{flushright}
          <>
      \end{flushright}
      ]],
      {
        i(1, ''),
      }
    )
  ),
  s(
    { trig = 'myjpd', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      の<>
      ]],
      {
        i(1, ''),
      }
    )
  ),
  s(
    { trig = 'mysec', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \section{<>} \label{sec:<>}
      ]],
      {
        i(1, ''),
        i(2, ''),
      }
    )
  ),
  s(
    {
      trig = 'mysec',
      dscr = 'section',
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
    { trig = 'mysubs', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \subsection{<>}
      ]],
      {
        i(1, ''),
      }
    )
  ),
  s(
    { trig = 'fmta', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
        s(
          { trig = "<>", snippetType = "autosnippet", priority = 2000 },
          fmta(
            <>
            <>
            <>,
            {
              i(1, ""),
            }
          )
        ),
      ]],
      {
        i(1, 'key'),
        t '[[',
        i(2, ''),
        t ']]',
      }
    )
  ),
  s(
    { trig = 'myicf', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \inputcodefile{<>}{code/<>/<>}{<>}{<>}{<>}
      ]],
      {
        c(1, { t 'shell', t 'python', t 'go', t 'latex' }),
        c(2, { t 'shell', t 'python', t 'go', t 'latex' }),
        i(3, ''),
        i(4, 'title'),
        c(5, { t 'Shell', t 'Python', t 'Go', t 'LaTex' }),
        c(6, { t '001.jpeg', t '002.jpeg', t '003.png' }),
      }
    )
  ),
  s(
    {
      trig = 'myicf',
      dscr = 'inputcodefile',
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
    { trig = 'myinp', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \input{documents/chapter_<>}
      ]],
      {
        i(1, '1'),
      }
    )
  ),
  s(
    { trig = 'myiml', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      $<>$
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myiml',
      dscr = 'math line',
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
    { trig = 'myfrac', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \frac{<>}{<>}
      ]],
      {
        i(1, 'fenzi'),
        i(2, 'fenmu'),
      }
    )
  ),
  s(
    { trig = 'noderec', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \node (s<>) at (<>,<>)[rectangle, rounded corners, draw=blue!50, inner sep=2pt, fill=<>, font=\small]{<>};
      ]],
      {
        i(1, '1'),
        i(2, 'x'),
        i(3, 'y'),
        c(4, { t 'Teal!50', t 'Tan!50', t 'MediumOrchid!50' }),
        i(5, 'text'),
      }
    )
  ),
  s(
    { trig = 'drawkh', snippetType = 'autosnippet', priority = 2000 },
    c(1, {
      sn(nil, {
        t '\\draw[decorate, decoration={calligraphic brace, raise=4pt, amplitude=3mm',
        i(1),
        t '}, thick] (s1.north)--(s2.south);',
      }),
      sn(nil, {
        t '\\draw[decorate, decoration={calligraphic brace, raise=4pt, amplitude=3mm, mirror',
        i(1),
        t '}, thick] (s1.north)--(s2.south);',
      }),
    })
  ),
  s(
    { trig = 'drawpath', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \draw[purple, <>, thick] (s1.<>) to [in=-90, out=90] (s2.<>);
      ]],
      {
        i(1, '->'),
        c(2, { t 'west', t 'east', t 'south', t 'north' }),
        c(3, { t 'west', t 'east', t 'south', t 'north' }),
      }
    )
  ),
  s(
    { trig = 'nodecrec', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \node (s<>) at (<>,<>)[rectangle, text width=12pt, text height=3pt, inner sep=2pt, draw=black, fill=<>]{};
      \node[right=0.5ex of s<>] {\textit{<>}};
      ]],
      {
        i(1, '1'),
        i(2, 'x'),
        i(3, 'y'),
        i(4, 'Color'),
        rep(1),
        rep(4),
      }
    )
  ),
  s(
    { trig = 'myfac', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \textcolor{<>}{\faIcon{<>}}\\
      ]],
      {
        c(1, {
          t 'Black',
          t 'Teal',
          t 'PaleVioletRed',
          t 'DarkGreen',
          t 'OliveDrab',
          t 'DeepPink',
          t 'MediumPurple',
          t 'DarkOrchid',
          t 'Brown',
          t 'Coral',
          t 'BurlyWood',
          t 'CadetBlue',
        }),
        i(2, 'IconName'),
      }
    )
  ),
  s(
    {
      trig = 'myfac',
      dscr = 'faIcon Textcolor',
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
    { trig = 'myuse', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \usepackage{<>}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = 'mybeg', snippetType = 'autosnippet', priority = 2000 },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    )
  ),
  s(
    {
      trig = 'mybeg',
      dscr = 'Envirenment',
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
      %  <>: <>
      ]],
      {
        c(1, { t 'NOTE', t 'TODO', t 'WARN', t 'FIX', t 'HACK', t 'PERF' }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = ';a',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>
      ]],
      {
        t '\\alpha',
      }
    )
  ),
  s(
    { trig = ';a', dscr = '\alpha', regTrig = false, snippetType = 'snippet' },
    fmta(
      [[

      ]],
      {}
    )
  ),
  s(
    {
      trig = 'mydoc2',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \documentclass[a4paper, 10pt]{<>}
      \usepackage[hyperref=true, backend=bibtex, sorting=none, backref=true]{biblatex} %style=authoryear-icomp
      \usepackage{amsmath, amsfonts, amsthm,amssymb, mathtools}
      \usepackage[varbb]{newpxmath}
      \usepackage{mathtools}
      \usepackage{bookmark}
      \usepackage{xfrac}
      \usepackage[dvipsnames, svgnames, x11names]{xcolor}
      \usepackage[a4paper, left=1.5cm, right=1cm, top=1.5cm, bottom=1.5cm]{geometry}
      \usepackage{tocloft} % 目录设置宏包
      \usepackage{enumerate}
      \usepackage{fontspec, xunicode-addon} % 显示中文、韩文(CJK)字符
      \usepackage[utf8]{inputenc}
      \usepackage{kotex} % korea font space
      \usepackage{multicol}
      \usepackage{verse} % 诗歌
      \usepackage[fleqn]{amsmath}
      \usepackage{etoolbox}"
      \usepackage{pifont} % \ding{51}
      \usepackage[runin]{abstract}
      \usepackage{lipsum} % 插入例子
      \usepackage{xifthen}
      \usepackage{tcolorbox}
      \usepackage{enumitem}
      \usepackage{tasks}
      \usepackage{graphicx}
      \usepackage{tabularray}
      \usepackage[slantfont, boldfont]{xeCJK}
      \usepackage{titling}
      \usepackage[explicit]{titlesec}
      \usepackage{metalogo}
      \usepackage{chngcntr}
      \usepackage{fontawesome5}
      \usepackage{IEEEtrantools}
      \usepackage{newclude}
      \usepackage{minted} % sudo pip install pygments % --shell-escape
      \usepackage[titletoc]{appendix} % 附录
      \usepackage{todonotes} % 批注将来需要做的事项
      \usepackage[noautomatic]{imakeidx} % 关键字索引 导言区\index{}
      \usepackage[totoc, hangindent=2em, subindent=0.8em, initsep=12pt, font=small, unbalanced=true]{idxlayout}
      \usepackage{pst-plot}
      \usepackage[customcolors, shade]{hf-tikz}
      \usetikzlibrary{tikzmark}
      \usepackage{tkz-euclide}
      \usepackage{fancyhdr} % 设置页眉、页脚
      \usepackage{lastpage} % 显示总页数
      \usepackage{afterpage}
      \usepackage{nameref}
      \usepackage[ruled, vlined, linesnumbered]{algorithm2e}
      \usepackage{comment} % enable the use of multi-line comments (\ifx \fi)
      \usepackage{import}
      \usepackage{transparent}
      \usepackage{hyperref, theoremref} % 此宏包必须最后导入才能跳转到引用位置

      \usemintedstyle{xcode}

      % --------------------------------------------------------
      % -------------- input sources file begin ----------------
      % --------------------------------------------------------
      \input{sources/font}
      \input{sources/format}
      \input{sources/mypagestyle}
      \input{sources/enumitem}
      \input{sources/newcommand}
      \input{sources/tasks}
      \input{sources/png}
      \input{sources/graphics}
      \input{sources/defcolor}
      \input{sources/mytblr}
      \input{sources/href}
      \input{sources/tcolorbox}
      \input{sources/entry}
      \input{sources/attrib}
      \input{sources/multicol}
      \input{sources/bib}
      \input{sources/makeindex}
      % --------------------------------------------------------
      % --------------- input sources file end -----------------
      % --------------------------------------------------------

      % ---------------- begin document start ------------------",
      \begin{document}"

      \pagestyle{mypagestyle}

      \input{sources/author-title} % 封面页面

      \thispagestyle{empty}
      \afterpage{\thispagestyle{plain}}
      \renewcommand{\thepage}{\Roman{page}}
      \setcounter{page}{1}
      \tableofcontents

      \clearpage
      \listoftables % 表格目录

      \clearpage
      \listoffigures % 图片目录

      %\listoftodos
      \newpage

      \input{sources/basic-info}
      \input{sources/abstract}

      \renewcommand{\thepage}{\arabic{page}}
      \setcounter{page}{1}

      %--------- 前言 ---------
      \input{documents/preface}

      <>
      \input{documents/chapter_1}
      %\input{documents/chapter_2}
      %\input{documents/chapter_3}
      %\input{documents/chapter_4}
      %\input{documents/chapter_5}
      %\input{documents/chapter_6}
      %\input{documents/chapter_7}
      %\input{documents/chapter_8}
      %\input{documents/chapter_9}
      %\input{documents/chapter_10}
      %\input{documents/chapter_11}
      %\input{documents/chapter_12}
      %\input{documents/chapter_13}
      %\input{documents/chapter_14}
      %\input{documents/chapter_15}

      %\cite{texbook1986} %\nocite{*}
      %-------------------- 打印文献 start --------------------
      \printbibliography[title={\kaiti 参考文献}, sorting=nyt] % 打印参考文献
      \addcontentsline{toc}{chapter}{参考文献}
      %-------------------- 打印文献 end ----------------------

      %---------------------- 附录 start ----------------------
      \input{sources/appendices}
      %---------------------- 附录 end ------------------------

      % 打印关键字索引
      \printindex % \index{}

      \end{document}
      ]],
      {
        c(1, { t 'report', t 'article' }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'mydefc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \definecolor{<>}{<>}{<>}
      ]],
      {
        i(1, 'myname'),
        c(2, { t 'RGB', t 'HTML', t 'gray' }),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'mydefc',
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
      trig = 'myimgs',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>
      ]],
      {
        c(1, { t '001.jpeg', t '002.jpeg', t '003.png' }),
      }
    )
  ),
  s(
    {
      trig = 'myimgs',
      dscr = 'images',
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
      trig = 'mylib',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \mylib{<>}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'mylib',
      dscr = 'mylib',
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
      trig = 'mybox1',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \xmybox[green]{<>}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'mybox1',
      dscr = 'xmybox',
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
      trig = 'mybox2',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[

      \begin{mybox2}{<>}{cha<>-<>}
        <>
      \end{mybox2}
      ]],
      {
        i(1, 'titleName'),
        i(2, '1'),
        i(3, '1'),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mybox2',
      dscr = '2 columns box',
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
      trig = 'myeqb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{center}
        \begin{myequationbox}
          <>
        \end{myequationbox}
      \end{center}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myeqb',
      dscr = 'def equation box',
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
      trig = 'mytheo',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{YetAnotherTheorem}{<>}{<>}
        <>
      \end{YetAnotherTheorem}
      ]],
      {
        i(1, 'title'),
        i(2, 'lablename:theo'),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'mytheo',
      dscr = 'Theorem',
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
      trig = 'mydef',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{Definition}{<>}{<>}
        <>
      \end{Definition}
      ]],
      {
        i(1, 'title'),
        i(2, 'lablename:def'),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'mydef',
      dscr = 'Definition',
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
      trig = 'mycor',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{Corollary}{<>}{<>}
        <>
      \end{Corollary}
      ]],
      {
        i(1, 'title'),
        i(2, 'lablename:cor'),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'myref',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \autoref{<>:<>}
      ]],
      {
        c(1, { t 'chap', t 'sec', t 'theo', t 'def', t 'cor' }),
        i(2, 'refname'),
      }
    )
  ),
  s(
    {
      trig = 'myref',
      dscr = 'ref',
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
      trig = 'mylb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \label{<>:<>}
      ]],
      {
        c(1, { t 'chap', t 'sec', t 'theo', t 'def', t 'cor' }),
        i(2, 'labelname'),
      }
    )
  ),
  s(
    {
      trig = 'mylb',
      dscr = 'label',
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
      trig = 'myrtb',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{myrotatebox}{<>}{<>}
        <>
      \end{myrotatebox}
      ]],
      {
        i(1, 'title'),
        i(2, '30'),
        i(3),
      }
    )
  ),
  s(
    {
      trig = 'myrtb',
      dscr = 'rotatebox',
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
      trig = 'mytri',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{tcbraster}[
        raster columns=<>,
        raster rows=1,
        raster equal height,
		    raster column skip=1.8cm, % 0.5mm
		    nobeforeafter,
        enhanced,
        raster force size=false,
        size=fbox,
        colframe=red!50!black,
        colback=red!20!black,
        fonttitle=\bfseries,
        center title,
        % drop fuzzy shadow,
      ]
        \tcbincludegraphics[title=<>, hbox, graphics options={width=3cm}]{images/<>}
        \tcbincludegraphics[title=<>, hbox, graphics options={width=3cm}]{images/<>}
      \end{tcbraster}
      ]],
      {
        i(1, '2'),
        i(2, 'imgname'),
        i(3, 'imgPath'),
        i(4, 'imgname'),
        i(5, 'imgPath'),
      }
    )
  ),
  s(
    {
      trig = 'mytri',
      dscr = 'tcbraster img',
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
      trig = 'mylips',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \lipsum[<>]
      ]],
      {
        i(1, '1-3'),
      }
    )
  ),
  s(
    {
      trig = 'mylips',
      dscr = 'lipsum',
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
      trig = 'mymini',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{minipage}[t]{0.30\textwidth}
        \vspace{0pt}
        %\centering
        % Tracks:\\
	      %\noindent\textcolor{teal}{\rule{\textwidth}{1pt}}
        %\includegraphics[width=\textwidth]{images/}
        \tcbincludegraphics[
          title=nihao,
          center title,
          % frame hidden,
          fonttitle=\bfseries,
          size=fbox,
          colframe=red!50!black,
          colback=red!20!black,]{images/<>}
      \end{minipage}
      %\hspace{0.8cm}
      ]],
      {
        i(1, 'imgPath'),
      }
    )
  ),
  s(
    {
      trig = 'mymini',
      dscr = 'minipage',
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
      trig = 'myrule',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \noindent\textcolor{<>}{\rule{\textwidth}{1pt}}
      ]],
      {
        c(1, { t 'black', t 'gray', t 'teal' }),
      }
    )
  ),
  s(
    {
      trig = 'myrule',
      dscr = 'ruleline',
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
      trig = 'myimgi',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \includegraphics[width=\textwidth]{images/<>}
      ]],
      {
        i(1, 'imgPath'),
      }
    )
  ),
  s(
    {
      trig = 'myimgi',
      dscr = 'includegraphics',
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
      trig = 'myimgt',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
        \tcbincludegraphics[
          title=nihao,
          center title,
          % frame hidden,
          fonttitle=\bfseries,
          size=fbox,
          colframe=red!50!black,
          colback=red!20!black,]{images/<>}
      ]],
      {
        i(1, 'imgPath'),
      }
    )
  ),
  s(
    {
      trig = 'myimgt',
      dscr = 'tcbincludegraphics',
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
      trig = 'myverse',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
	    \noindent\textcolor{gray}{\rule{\textwidth}{1pt}}
      \begin{multicols}{2}
        \settowidth{\versewidth}{\kr 준비없이 비를 만난것처럼}
        \poemtitle{\kr 좋은 사람} %title
        \attrib{
          \textbf{Author:} \krt 박효신(1981) \\
          \textbf{Release:} 2016-06-01 \\
          \textbf{Album:} The Gold（Original Recording Remastered）
        }         %author
	      \noindent\textcolor{gray}{\rule{\linewidth}{1pt}}
        \begin{verse}[\versewidth]
          {\kr\small % huge large normalsize small footnotesize
            준비없이 비를 만난것처럼<> \\
          }
        \end{verse}

        \settowidth{\versewidth}{像毫无防备淋过了一场雨}
        \poemtitle{\kaiti\normalsize 与好的人}  %title
        \attrib{
          \textbf{\kaiti Author:} 朴孝信(1981) \\
          \textbf{\kaiti Release：} 2016-06-01 \\
          \textbf{\kaiti Album：} The Gold（Original Recording Remastered）
        }             %author
	      \noindent\textcolor{gray}{\rule{\linewidth}{1pt}}
        \begin{verse}[\versewidth]
          \small % huge large normalsize small footnotesize
          像毫无防备淋过了一场雨 \\
        \end{verse}
      \end{multicols}
	    \noindent\textcolor{gray}{\rule{\textwidth}{1pt}}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myverse',
      dscr = 'verse',
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
      trig = 'myenum',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{enumerate}[itemsep=0pt, leftmargin=1cm, before=\normalfont\small, start=1] % footnotesize(8pt) small(9pt) normalsize(10pt)
        \item <> % \krt
        \item <>
        \item <>
      \end{enumerate}
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
      trig = 'myenum',
      dscr = 'enumrate',
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
      trig = 'mytblr',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{mytblr}[
          \caption = {<>},
          ]{
          colspec = {|c|X[2.8]|X[2.8]|X[2.8]|},
          % row{odd} = {bg=white},
	        % row{1} = {bg=myteal, fg=white},
          }
          \myhline
          \SetRow{c} ID & <> & <> & <> \\
          \myhline

          \mycnta & <> & <> & <> \\

          \myhline
      \end{mytblr}
      ]],
      {
        i(1, 'caption name'),
        i(2, 'column1'),
        i(3, 'column2'),
        i(4, 'column3'),
        i(5, 'text1'),
        i(6, 'text2'),
        i(7, 'text6'),
      }
    )
  ),
  s(
    {
      trig = 'mytblr',
      dscr = 'tabularray',
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
      trig = 'tblr',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{center}
          \begin{tblr}[
              \caption = {<>},
              ]{
              width = 0.6\linewidth,
              % colspec = {XXXX},
              cells = {c},
              cell{1}{-} = {font=\bfseries\kaiti},
              hline{1} = {0.8pt},
              hline{Z} = {0.8pt},
              hline{2} = {0.4pt},
              % cell{3}{3} = {font = \bfseries, fg = red, bg = blue, cmd = \fbox}, %  NOTE: 单元格格式设置
              % cell{1}{1} = {c=1, r=2}{m}, %  NOTE: 单元格合并
              }
               <> & <> & <> \\

               <> & <> & <> \\
          \end{tblr}
      \end{center}
      ]],
      {
        i(1, 'caption name'),
        i(2, 'column1'),
        i(3, 'column2'),
        i(4, 'column3'),
        i(5, 'text1'),
        i(6, 'text2'),
        i(7, 'text6'),
      }
    )
  ),
  s(
    {
      trig = 'tblr',
      dscr = 'three-line table',
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
      trig = 'mycell',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      cell{<>}{<>} = {fg = <>, bg = white, cmd = \textbf},
      ]],
      {
        i(1, 'row'),
        i(2, 'col'),
        i(3, 'Green'),
      }
    )
  ),
  s(
    {
      trig = 'mycell',
      dscr = 'set cell',
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
      trig = 'myhbc',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      cell{<>}{<>} = {c=<>, r=<>}{<>},
      ]],
      {
        i(1, 'row'),
        i(2, 'col'),
        i(3, 'rowN'),
        i(4, 'colN'),
        c(5, { t 'm', t 'c' }),
      }
    )
  ),
  s(
    {
      trig = 'myhbc',
      dscr = 'hebing cell',
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
      trig = 'myadf',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \input{documents/<>}
      ]],
      {
        i(1, 'addDocumentFile'),
      }
    )
  ),
  s(
    {
      trig = 'myadf',
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
      trig = 'myfont',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>{<>} % xsy | wysxk | tyzx | jxp
      ]],
      {
        c(1, { t '\\xsy', t '\\wysxk', t '\\tyzx', t '\\jxp' }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myfont',
      dscr = 'xingshukaishu',
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
      \mbox{\jxp \textcolor{DarkMagenta}{Step<>:<>}}
      \begin{equation}
      \begin{aligned}
        \mbox{\jxp 借：} & \mbox{<>}\\
                    & \mbox{<>}\\
        \mbox{\jxp 贷：} & \mbox{<>}\\
                    & \mbox{<>}\\
      \end{aligned}
      \end{equation}
      ]],
      {
        i(1, '1'),
        i(2, ''),
        i(3, 'zc1'),
        i(4, 'zc2'),
        i(5, 'fz1'),
        i(6, 'fz2'),
      }
    )
  ),
  s(
    {
      trig = 'myfl',
      dscr = 'kuaijifenlu',
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
      trig = 'myald',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \begin{aligned}
          <>
      \end{aligned}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myald',
      dscr = 'aligned Envirenment',
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
      trig = 'myudm',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \uldash{\mbox{<>}}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myudm',
      dscr = 'uldash',
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
      trig = 'myulm',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <>{\mbox{<>}}
      ]],
      {
        c(1, { t '\\ul', t '\\hl', t '\\st' }),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myulm',
      dscr = 'underline hl st',
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
      trig = 'myet',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \entry
      {<>}
      {
          <> \\
      }
      {}
      {}
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    {
      trig = 'myet',
      dscr = 'entry',
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
      trig = 'myddh',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \geqslant <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myddh',
      dscr = 'dayuxiaoyuhao',
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
      trig = 'myxdh',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \leqslant <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myxdh',
      dscr = 'xiaoyudengyuhao',
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
      trig = 'myfxx',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      $\backslash$<>
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'myfxx',
      dscr = 'backslash',
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
      \SetCell<><><>2<>{c} <>
      ]],
      {
        t '[',
        c(1, { t 'r', t 'c' }),
        t '=',
        t ']',
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mysc',
      dscr = 'setcell',
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
      trig = 'mycl',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \cline{<>-<>}
      ]],
      {
        i(1, '1'),
        i(2, '3'),
      }
    )
  ),
  s(
    {
      trig = 'mycl',
      dscr = 'cline',
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
      trig = 'mycir',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \circled{<>}
      ]],
      {
        i(1, '1'),
      }
    )
  ),
  s(
    {
      trig = 'mycir',
      dscr = 'circled',
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
      %  NOTE: <>
      ]],
      {
        i(1),
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
      trig = 'mykr',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      \kr{<>}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = 'mykr',
      dscr = 'korea',
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
      trig = 'myts',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      $\times$ <>
      ]],
      {
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'myts',
      dscr = 'times',
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
      trig = 'mymt',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      $<>$ <>
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'mymt',
      dscr = 'math',
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
      trig = 'myfs',
      regTrig = false,
      snippetType = 'autosnippet',
      priority = 2000,
    },
    fmta(
      [[
      <><>
      ]],
      {
        t '\\',
        c(1, { t 'large', t 'normalsize', t 'small', t 'footnotesize' }),
      }
    )
  ),
  s(
    {
      trig = 'myfs',
      dscr = 'fontsize',
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
      trig = '([bBpvV])mat(%d+)x(%d+)([ar])',
      regTrig = true,
      name = 'matrix',
      dscr = 'matrix trigger lets go',
      hidden = true,
    },
    fmta(
      [[
      \begin{<>}<>
      <>
      \end{<>}
      ]],
      {
        f(function(_, snip)
          return snip.captures[1] .. 'matrix' -- captures matrix type
        end),
        f(function(_, snip)
          if snip.captures[4] == 'a' then
            out = string.rep('c', tonumber(snip.captures[3]) - 1) -- array for augment
            return '[' .. out .. '|c]'
          end
          return '' -- otherwise return nothing
        end),
        d(1, mat),
        f(function(_, snip)
          return snip.captures[1] .. 'matrix' -- i think i could probably use a repeat node but whatever
        end),
      }
    )
  ),
  s('mylss', {
    t '\\begin{tabular}{',
    i(1, '0'),
    t { '}', '' },
    d(2, table_node, { 1 }, {}),
    d(3, rec_table, { 1 }),
    t { '', '\\end{tabular}' },
  }),
}
