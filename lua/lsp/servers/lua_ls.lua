local M = {}

M.settings = {
  Lua = {
    -- runtime = {
    --   version = "LuaJIT",
    --   special = {
    --     spec = "require",
    --   },
    -- },
    diagnostics = {
      disable = { 'incomplete-signature-doc', 'trailing-space' },
      -- enable = false,
      groupSeverity = {
        strong = 'Warning',
        strict = 'Warning',
      },
      groupFileStatus = {
        ['ambiguity'] = 'Opened',
        ['await'] = 'Opened',
        ['codestyle'] = 'None',
        ['duplicate'] = 'Opened',
        ['global'] = 'Opened',
        ['luadoc'] = 'Opened',
        ['redefined'] = 'Opened',
        ['strict'] = 'Opened',
        ['strong'] = 'Opened',
        ['type-check'] = 'Opened',
        ['unbalanced'] = 'Opened',
        ['unused'] = 'Opened',
      },
      unusedLocalExclude = { '_*' },
    },
    -- diagnostics = {
    --   globals = {
    --     'packer_plugins',
    --     'bit',
    --     'require',
    --     'nvim',
    --     'python',
    --     'P',
    --     'RELOAD',
    --     'PASTE',
    --     'STORAGE',
    --     'use',
    --     'use_rocks',
    --   },
    --   disable = { 'missing-fields' },
    -- },
    completion = {
      workspaceWord = true,
      callSnippet = 'Both',
      -- callSnippet = 'Replace',
    },
    format = {
      enable = false,
      defaultConfig = {
        indent_style = 'space',
        indent_size = '2',
        continuation_indent_size = '2',
      },
    },
    telemetry = {
      enable = false,
    },
    hint = {
      enable = true,
      arrayIndex = 'Disable', -- "Enable" | "Auto" | "Disable"
      -- await = true,
      paramName = 'Disable', -- "All" | "Literal" | "Disable"
      paramType = true,
      semicolon = 'Disable', -- "All" | "SameLine" | "Disable"
      setType = false,
    },
    type = {
      castNumberToInteger = true,
    },
    workspace = {
      library = {
        [vim.fn.expand '$VIMRUNTIME/lua'] = true,
        [vim.fn.stdpath 'config' .. '/lua'] = true,
      },
      checkThirdParty = false,
    },
  },
}

return M
