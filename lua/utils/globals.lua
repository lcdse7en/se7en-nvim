P = function(v)
  print(vim.print(v))
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

GIT_CWD = function()
  return vim.fn.systemlist('git rev-parse --show-toplevel')[1] .. '/'
end

function _G.launch_ext_prog(prog, ...)
  vim.fn.system(prog .. ' ' .. table.concat({ ... }, ' '))
end

function _G.open_url(url, prefix)
  -- launch_ext_prog("google-chrome-stable", (prefix or "") .. url)
  launch_ext_prog('firefox', (prefix or '') .. url)
end

--- Trim newline at eof, trailing whitespace.
function _G.perform_cleanup()
  local patterns = {
    -- Remove leading empty lines
    [[%s/\%^\n//e]],
    -- Remove trailing empty lines
    [[%s/$\n\+\%$//e]],
    -- Remove trailing spaces
    [[%s/\s\+$//e]],
    -- Remove trailing "\r"
    [[%s/\r\+//e]],
  }

  local view = vim.fn.winsaveview()

  for _, v in pairs(patterns) do
    vim.cmd(string.format('keepjumps keeppatterns silent! %s', v))
  end

  vim.fn.winrestview(view)
end
