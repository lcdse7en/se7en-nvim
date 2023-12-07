
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
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_cur_pos", { clear = true }),
  pattern = "*",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"zz" | endif]],
  desc = "Restore cursor position to last known position on read.",
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

