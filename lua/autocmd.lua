
--  NOTE: Jump out of parenthetical quotation marks
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*",
  callback = function()
    vim.cmd [[
    inoremap <silent> ii <C-\><C-n>:call search('[>)\]}"'']', 'W')<CR>a
     ]]
  end,
})
--  NOTE: go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = vim.api.nvim_create_augroup("restore_cur_pos", { clear = true }),
--   pattern = "*",
--   command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"zz" | endif]],
--   desc = "Restore cursor position to last known position on read.",
-- })
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
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 }
  end,
})


--  NOTE: Fix fold issue of files opened by telescope
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = vim.api.nvim_create_augroup("Telescope_fold", { clear = true }),
  callback = function()
    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
      once = true,
      command = "normal! zx",
    })
  end,
})

--  NOTE: auto close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
      layout[1] == "leaf"
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
      and layout[3] == nil
    then
      vim.api.nvim_command [[confirm quit]]
    end
  end,
})

--  NOTE: Automaically reload the file if it is changed outsize of Nvim
local group = vim.api.nvim_create_augroup("auto_read", { clear = true })
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  group = group,
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
  end,
})
vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold", "TermClose", "TermLeave" }, {
  pattern = "*",
  group = group,
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd "checktime"
    end
  end,
})


--  NOTE:  Don't auto commenting new lines
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  command = [[set formatoptions-=cro]],
})
--  NOTE: auto close some filetypes with <q>
local close_with_q = vim.api.nvim_create_augroup("close_with_q", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = close_with_q,
  pattern = {
    "fugitive",
    "tsplayground",
    "PlenaryTestPopup",
    "qf",
    "toggleterm",
    "help",
    "lspinfo",
    "man",
    "notify",
    "aerial",
    "qf",
    "NvimTree",
    "dap-float",
    "null-ls-info",
    "checkhealth",
    "spectre_panel",
    "startuptime",
    "neotest-output",
    "neotest-summary",
    "neotest-output-panel",
    "terminal",
    "copilot",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", ":q<cr>", { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

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
      vim.cmd.wincmd('L')
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
        vim.cmd('redraw')
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
