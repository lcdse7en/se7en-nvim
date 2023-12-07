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
      globals = {
        "packer_plugins",
        "bit",
        "require",
        "nvim",
        "python",
        "P",
        "RELOAD",
        "PASTE",
        "STORAGE",
        "use",
        "use_rocks",
      },
      disable = { "missing-fields" },
    },
    completion = {
      callSnippet = "Replace",
    },
    format = { enable = false },
    telemetry = {
      enable = false,
    },
    hint = {
      enable = true,
      arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
      await = true,
      paramName = "Disable", -- "All" | "Literal" | "Disable"
      paramType = true,
      semicolon = "Disable", -- "All" | "SameLine" | "Disable"
      setType = false,
    },
    workspace = {
      library = {
        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        [vim.fn.stdpath "config" .. "/lua"] = true,
      },
      checkThirdParty = false,
    },
  },
}

return M
