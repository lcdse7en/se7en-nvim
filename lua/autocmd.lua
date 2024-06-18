--  NOTE: Jump out of parenthetical quotation marks
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  callback = function()
    vim.cmd [[
    inoremap <silent> ii <C-\><C-n>:call search('[>)\]}"'']', 'W')<CR>a
     ]]
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

--  NOTE: go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Jump to the last place you’ve visited in a file before exiting',
  callback = function()
    local ignore_ft = { 'neo-tree', 'toggleterm', 'lazy' }
    local ft = vim.bo.filetype
    if not vim.tbl_contains(ignore_ft, ft) then
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end
  end,
})
--  NOTE: Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup('TrimWhiteSpaceGrp', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})

--  NOTE: Fix fold issue of files opened by telescope
vim.api.nvim_create_autocmd({ 'BufRead' }, {
  group = vim.api.nvim_create_augroup('Telescope_fold', { clear = true }),
  callback = function()
    vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
      once = true,
      command = 'normal! zx',
    })
  end,
})

--  NOTE: auto close NvimTree
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
  pattern = 'NvimTree_*',
  callback = function()
    local layout = vim.api.nvim_call_function('winlayout', {})
    if
      layout[1] == 'leaf'
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), 'filetype') == 'NvimTree'
      and layout[3] == nil
    then
      vim.api.nvim_command [[confirm quit]]
    end
  end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   desc = 'Enable inlay hints',
--   callback = function(event)
--     local id = vim.tbl_get(event, 'data', 'client_id')
--     local client = id and vim.lsp.get_client_by_id(id)
--     if client == nil or not client.supports_method 'textDocument/inlayHint' then
--       return
--     end
--
--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(0))
--   end,
-- })

--  NOTE: Automaically reload the file if it is changed outsize of Nvim
local group = vim.api.nvim_create_augroup('auto_read', { clear = true })
vim.api.nvim_create_autocmd({ 'FileChangedShellPost' }, {
  pattern = '*',
  group = group,
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded!', vim.log.levels.WARN, { title = 'nvim-config' })
  end,
})
vim.api.nvim_create_autocmd({ 'FocusGained', 'CursorHold', 'TermClose', 'TermLeave' }, {
  pattern = '*',
  group = group,
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd 'checktime'
    end
  end,
})

--  NOTE:  Don't auto commenting new lines
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   command = [[set formatoptions-=cro]],
-- })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  desc = 'Do not auto comment on new line',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.linebreak = true
    vim.b.editorconfig = false
  end,
  desc = 'Set gitcommit config',
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    'docker-compose.yml',
    'docker-compose.yaml',
    'compose.yml',
    'compose.yaml',
        -- stylua: ignore
        'compose.*.yaml',
    'compose.*.yml',
  },
  command = 'set filetype=yaml.docker-compose',
})

--  NOTE: auto close some filetypes with <q>
local close_with_q = vim.api.nvim_create_augroup('close_with_q', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = close_with_q,
  pattern = {
    'fugitive',
    'tsplayground',
    'PlenaryTestPopup',
    'qf',
    'toggleterm',
    'help',
    'lspinfo',
    'man',
    'notify',
    'aerial',
    'qf',
    'NvimTree',
    'dap-float',
    'null-ls-info',
    'checkhealth',
    'spectre_panel',
    'startuptime',
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
    'terminal',
    'copilot',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', ':q<cr>', { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_autocmd('FileType', { pattern = 'man', command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- Autoformatting
if PREF.lsp.format_on_save then
  vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
      local client = vim.lsp.get_clients({ bufnr = 0 })[1]
      if client then
        vim.lsp.buf.format()
      end
    end,
  })
end

-- Set default colorcolumn
vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Set colorcolumn equals textwidth',
  callback = function(data)
    local tw = vim.bo[data.buf].textwidth
    vim.opt_local.colorcolumn = tostring(tw)
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Open :help with vertical split',
  pattern = { '*.txt' },
  callback = function()
    if vim.bo.filetype == 'help' then
      vim.cmd.wincmd 'L'
    end
  end,
})

-- Autoenable when 'relativenumber' is set to true. Need to restart neovim
if vim.opt.relativenumber:get() then
  local group = vim.api.nvim_create_augroup('toggle_relnum', { clear = false })
  local function set_relnum_back(win)
    vim.api.nvim_create_autocmd('CmdlineLeave', {
      group = group,
      once = true,
      callback = function()
        vim.wo[win].relativenumber = true
      end,
    })
  end

  vim.api.nvim_create_autocmd('CmdlineEnter', {
    desc = 'Disables `relativenumber` when entering command line mode and enables it again when leaving',
    group = group,
    callback = function()
      local win = vim.api.nvim_get_current_win()
      if vim.wo[win].relativenumber then
        vim.wo[win].relativenumber = false
        vim.cmd 'redraw'
        set_relnum_back(win)
      end
    end,
  })
end

vim.api.nvim_create_autocmd('BufHidden', {
  desc = 'Delete [No Name] buffers',
  callback = function(data)
    if data.file == '' and vim.bo[data.buf].buftype == '' and not vim.bo[data.buf].modified then
      vim.schedule(function()
        pcall(vim.api.nvim_buf_delete, data.buf, {})
      end)
    end
  end,
})

--  NOTE: show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = vim.api.nvim_create_augroup('CursorLine', { clear = true }),
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  command = 'set nocursorline',
  group = vim.api.nvim_create_augroup('noCursorLine', { clear = true }),
})

--  NOTE: markdown vim-table-mode
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('vimtablemode', { clear = true }),
  pattern = { '*.md' },
  command = 'silent! TableModeEnable',
})
--  NOTE: tcpst format
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   group = vim.api.nvim_create_augroup('typstformat', { clear = true }),
--   pattern = { '*.typ' },
--   -- command = 'silent! :!prettypst --use-configuration %',
--   command = 'silent! :!prettypst --file-location=~/.config/nvim/prettypst.toml %',
--   -- command = 'silent! :!typstfmt %',
-- })
--  NOTE: cargo install --git https://github.com/Enter-tainer/typstyle
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('typstformat', { clear = true }),
  pattern = { '*.typ' },
  -- command = 'silent! :!prettypst --use-configuration %',
  command = 'silent! :!typstyle -i %',
})

--  NOTE: LuaSnipChoiceListSelecttions
local current_nsid = vim.api.nvim_create_namespace 'LuaSnipChoiceListSelections'
local current_win = nil

local function window_for_choiceNode(choiceNode)
  local buf = vim.api.nvim_create_buf(false, true)
  local buf_text = {}
  local row_selection = 0
  local row_offset = 0
  local text
  for _, node in ipairs(choiceNode.choices) do
    text = node:get_docstring()
    if node == choiceNode.active_choice then
      row_selection = #buf_text
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
  local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

  local extmark = vim.api.nvim_buf_set_extmark(
    buf,
    current_nsid,
    row_selection,
    0,
    { hl_group = 'incsearch', end_line = row_selection + row_offset }
  )
  local win = vim.api.nvim_open_win(buf, false, {
    relative = 'win',
    width = w,
    height = h,
    bufpos = choiceNode.mark:pos_begin_end(),
    style = 'minimal',
    border = 'rounded',
  })

  return { win_id = win, extmark = extmark, buf = buf }
end

function choice_popup(choiceNode)
  if current_win then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  end
  local create_win = window_for_choiceNode(choiceNode)
  current_win = {
    win_id = create_win.win_id,
    prev = current_win,
    node = choiceNode,
    extmark = create_win.extmark,
    buf = create_win.buf,
  }
end

function update_choice_popup(choiceNode)
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  local create_win = window_for_choiceNode(choiceNode)
  current_win.win_id = create_win.win_id
  current_win.extmark = create_win.extmark
  current_win.buf = create_win.buf
end

function choice_popup_close()
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  current_win = current_win.prev
  if current_win then
    local create_win = window_for_choiceNode(current_win.node)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
  end
end

vim.cmd [[
    augroup choice_popup
    au!
    au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
    au User LuasnipChoiceNodeLeave lua choice_popup_close()
    au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
    augroup END
]]

--  NOTE: Open new file insert text
vim.cmd [[
    augroup title_py
        autocmd!
        autocmd BufNewFile *.py exec":call SetTitle_py()"
          func SetTitle_py()
            if expand("%:e") == "py"
              call setline(1, "\# -*- coding: utf-8 -*-")
              call setline(2, "")
              call setline(3, "#********************************************")
              call setline(4, "# Author       : se7enlcd                   *")
              call setline(5, "# E-mail       : 2353442022@qq.com          *")
              call setline(6, "# Create_Time  : ".strftime("%Y-%m-%d %H:%M:%S")."        *")
              call setline(7, "# Description  :                            *")
              call setline(8, "#********************************************")
              call setline(9, "")
              call setline(10, "")
              call setline(11, "# import requests")
              call setline(12, "# from fake_useragent import UserAgent #  NOTE: ua = UserAgent(), headers = {'User-Agent': ua.random}")
              call setline(13, "# from loguru import logger")
              call setline(14, "# from tqdm.rich import tqdm")
              normal G
              normal o
              normal o
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

vim.cmd [[
    augroup title_lua
        autocmd!
        autocmd BufNewFile *.lua exec":call SetTitle_lua()"
          func SetTitle_lua()
            if expand("%:e") == "lua"
              call setline(1, "--********************************************")
              call setline(2, "-- Author      : se7enlcd                    *")
              call setline(3, "-- E-mail      : 2353442022@qq.com           *")
              call setline(4, "-- Create_Time : ".strftime("%Y-%m-%d %H:%M:%S")."         *")
              call setline(5, "-- Description :                             *")
              call setline(6, "--********************************************")
              call setline(7, "")
              call setline(8, "")
              normal G
              normal o
              normal o
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

vim.cmd [[
    augroup title_typ
        autocmd!
        autocmd BufNewFile *.typ exec":call SetTitle_typ()"
          func SetTitle_typ()
            if expand("%:e") == "typ"
              call setline(1, "//********************************************")
              call setline(2, "// Author      : se7enlcd                    *")
              call setline(3, "// E-mail      : 2353442022@qq.com           *")
              call setline(4, "// Create_Time : ".strftime("%Y-%m-%d %H:%M")."            *")
              call setline(5, "// Description :                             *")
              call setline(6, "//********************************************")
              call setline(7, "")
              call setline(8, "")
              call setline(9, '#import "../template/isc_report.typ": *')
              call setline(10, '#import "../template/cv.typ": *')
              call setline(11, "")
              call setline(12, "")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

vim.cmd [[
    augroup title_sh
        autocmd!
        autocmd BufNewFile *.sh exec":call SetTitle_sh()"
          func SetTitle_sh()
            if expand("%:e") == "sh"
              call setline(1, "#!/usr/bin/bash")
              call setline(2, "")
              call setline(3, "#********************************************")
              call setline(4, "# Author      : lcdse7en                    *")
              call setline(5, "# E-mail      : 2353442022@qq.com           *")
              call setline(6, "# Create_Time : ".strftime("%Y-%m-%d %H:%M:%S")."         *")
              call setline(7, "# Description :                             *")
              call setline(8, "#********************************************")
              call setline(9, "")
              call setline(10, "# source /etc/profile.d/import_shell_libs.sh")
              call setline(11, "")
              call setline(12, "")
              call setline(13, "RED=$(printf '\\033[31m')")
              call setline(14, "GREEN=$(printf '\\033[32m')")
              call setline(15, "YELLOW=$(printf '\\033[33m')")
              call setline(16, "BLUE=$(printf '\\033[34m')")
              call setline(17, "SKYBLUE=$(printf '\\033[36m')")
              call setline(18, "BOLD=$(printf '\\033[1m')")
              call setline(19, "RESET=$(printf '\\033[m')")
              call setline(20, "")
              call setline(21, "")
              call setline(22, "main() {")
              call setline(23, "    pass")
              call setline(24, "}")
              call setline(25, "")
              call setline(26, "main")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

vim.cmd [[
    augroup title_c
        autocmd!
        autocmd BufNewFile *.c exec":call SetTitle_c()"
          func SetTitle_c()
            if expand("%:e") == "c"
              call setline(1, "//*********************************************")
              call setline(2, "// Author      : lcdse7en                     *")
              call setline(3, "// E-mail      : 2353442022@qq.com            *")
              call setline(4, "// Create_Time : ".strftime("%Y-%m-%d %H:%M")."             *")
              call setline(5, "// Description :                              *")
              call setline(6, "//*********************************************")
              call setline(7, "")
              call setline(8, "#include <stdio.h>")
              call setline(9, "#include <stdlib.h>")
              call setline(10, "")
              call setline(11, "")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

--  NOTE: yaml
vim.cmd [[
    augroup title_yaml
        autocmd!
        autocmd BufNewFile *.yaml,*.yml exec":call SetTitle_yaml()"
          func SetTitle_yaml()
            if expand("%:e") == "yaml"
              call setline(1, "#********************************************")
              call setline(2, "# Author      : se7enlcd                     ")
              call setline(3, "# E-mail      : 2353442022@qq.com            ")
              call setline(4, "# Create_Time : ".strftime("%Y-%m-%d %H:%M")."             ")
              call setline(5, "# Description :                              ")
              call setline(6, "#********************************************")
              call setline(7, "")
              call setline(8, "")
            endif
            if expand("%:e") == "yml"
              call setline(1, "#********************************************")
              call setline(2, "# Author      : se7enlcd                     ")
              call setline(3, "# E-mail      : 2353442022@qq.com            ")
              call setline(4, "# Create_Time : ".strftime("%Y-%m-%d %H:%M")."             ")
              call setline(5, "# Description :                              ")
              call setline(6, "#********************************************")
              call setline(7, "")
              call setline(8, "")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

--  NOTE: latex
vim.cmd [[
    augroup title_latex
        autocmd!
        autocmd BufNewFile *.tex exec":call SetTitle_latex()"
          func SetTitle_latex()
            if expand("%:e") == "tex"
              call setline(1, "")
              call setline(2, "%********************************************")
              call setline(3, "% Author      : se7enlcd                     ")
              call setline(4, "% E-mail      : 2353442022@qq.com            ")
              call setline(5, "% Create_Time : ".strftime("%Y-%m-%d %H:%M")."             ")
              call setline(6, "% Description :                              ")
              call setline(7, "%********************************************")
              call setline(8, "")
              call setline(9, "")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

vim.cmd [[
    augroup title_go
        autocmd!
        autocmd BufNewFile *.go exec":call SetTitle_go()"
          func SetTitle_go()
            if expand("%:e") == "go"
              call setline(1, "//********************************************")
              call setline(2, "// Author      : se7enlcd                     ")
              call setline(3, "// E-mail      : 2353442022@qq.com            ")
              call setline(4, "// Create_Time : ".strftime("%Y-%m-%d %H:%M")."             ")
              call setline(5, "// Description :                              ")
              call setline(6, "//********************************************")
              call setline(7, "")
              call setline(8, "")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]]

--  NOTE: Set scripts to be executable from the shell
vim.cmd [[ au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x <afile> | endif ]]

--  NOTE: shell
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('sh', { clear = true }),
  pattern = {
    'sh',
  },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = false
    vim.bo.smartindent = true
    vim.opt.colorcolumn = '100'
    vim.opt.wrap = false
  end,
})
--  NOTE: python
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('python', { clear = true }),
  pattern = {
    'python',
  },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.copyindent = true
    vim.opt.colorcolumn = '100'
    vim.opt.wrap = false
  end,
})
--  NOTE: fish
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('fish', { clear = true }),
  pattern = {
    'fish',
  },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.copyindent = true
    vim.opt.colorcolumn = '100'
    vim.opt.wrap = false
  end,
})
--  NOTE: latex
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('tex', { clear = true }),
  pattern = {
    'tex',
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.opt.colorcolumn = '120'
    vim.opt.wrap = false
  end,
})
--  NOTE: typst
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('typst', { clear = true }),
  pattern = {
    '*.typ',
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.copyindent = true
    vim.opt.colorcolumn = '120'
    vim.wo.wrap = true
  end,
})

vim.api.nvim_create_autocmd({
  'TermResponse',
}, {
  group = group,
  callback = function()
    vim.cmd 'checktime'
  end,
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  callback = function(ev)
    if vim.bo[ev.buf].filetype == 'TelescopePrompt' then
      vim.cmd 'silent! stopinsert!'
    end
  end,
})

--  NOTE: Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'json', 'jsonc' },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
  desc = 'Fix conceallevel for json an help files',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local commentstrings = {
      dts = '// %s',
    }
    local ft = vim.bo.filetype
    if commentstrings[ft] then
      vim.bo.commentstring = commentstrings[ft]
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.md, *.txt', command = 'setlocal wrap' })

--  NOTE: TermOpen
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('se7enTermOpen', { clear = true }),
  pattern = 'term://*',
  callback = function()
    vim.cmd 'startinsert'
  end,
})

local conceal_ns = vim.api.nvim_create_namespace 'class_conceal'
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
  desc = 'Conceal HTML class attributes. Ideal for big TailwindCSS class lists',
  group = vim.api.nvim_create_augroup('class_conceal', { clear = true }),
  pattern = { '*.tsx' },
  callback = function(event)
    local bufnr = event.buf or vim.api.nvim_get_current_buf()

    ---Ref: https://gist.github.com/mactep/430449fd4f6365474bfa15df5c02d27b
    local language_tree = vim.treesitter.get_parser(bufnr, 'tsx')
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[1]:root()

    local ok, query = pcall(
      vim.treesitter.query.parse,
      'tsx',
      [[
    ((jsx_attribute
        (property_identifier) @att_name (#eq? @att_name "class")
        (string (string_fragment) @class_value)))
    ]]
    )
    if not ok then
      return
    end

    for _, captures, metadata in query:iter_matches(root, bufnr, root:start(), root:end_(), {}) do
      local start_row, start_col, end_row, end_col = captures[2]:range()
      vim.api.nvim_buf_set_extmark(bufnr, conceal_ns, start_row, start_col + 3, {
        end_line = end_row,
        end_col = end_col,
        conceal = '%', -- "…",
      })
    end
  end,
})

---resize kitty window, no padding when neovim is present.
local kitty_aug = vim.api.nvim_create_augroup('kitty_aug', { clear = true })
local resized = false
vim.api.nvim_create_autocmd({ 'UIEnter' }, {
  group = kitty_aug,
  pattern = '*',
  callback = function()
    if resized then
      return
    end
    vim.schedule(function()
      resized = true
      vim.cmd ':silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0 margin=0'
    end)
  end,
})
vim.api.nvim_create_autocmd('UILeave', {
  group = kitty_aug,
  pattern = '*',
  callback = function()
    if not resized then
      return
    end
    vim.cmd ':silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=8 margin=0'
  end,
})

vim.cmd [[
  "https://github.com/nvim-telescope/telescope.nvim/issues/559"
  augroup _fold_bug_solution
    autocmd!
    autocmd BufRead,BufWinEnter * ++once normal! zx
  augroup end

  augroup remember_folds
    autocmd!
    " autocmd BufWinLeave ?* mkview
    autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview
    autocmd BufEnter,BufWinEnter ?* silent! loadview
  augroup end
]]

vim.cmd [[
  augroup _set_typst
    autocmd!
    autocmd BufNewFile,BufRead *.typ setfiletype typst
  augroup end
]]

vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained', 'FocusLost', 'WinLeave' }, {
  callback = function()
    vim.cmd 'hi! Normal guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NonText guibg=NONE ctermbg=NONE'
  end,
})

vim.cmd [[
  augroup InsertDisable
    au!
    au InsertEnter * lua vim.b.miniindentscope_disable = true
    au InsertLeave * lua vim.b.miniindentscope_disable = false
  augroup END
]]
