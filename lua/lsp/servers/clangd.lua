local M = {}

local function get_binary_path_list(binaries)
  local path_list = {}
  for _, binary in ipairs(binaries) do
    local path = vim.fn.exepath(binary)
    if path ~= "" then
      table.insert(path_list, path)
    end
  end
  return table.concat(path_list, ",")
end

M.settings = {
  single_file_support = true,
  cmd = {
    "clangd",
    "-j=12",
    "--enable-config",
    "--background-index",
    "--pch-storage=memory",
    -- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
    "--query-driver=" .. get_binary_path_list { "clang++", "clang", "gcc", "g++" },
    "--clang-tidy",
    "--offset-encoding=utf-16",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--limit-references=3000",
    "--limit-results=350",
  },
}

return M
