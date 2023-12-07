return {
  "chrisgrieser/nvim-recorder",
  event = "VeryLazy",
  dependencies = { "rcarriga/nvim-notify" },
  keys = {
    -- these must match the keys in the mapping config below
    { "q", desc = " Start Recording" },
    { "Q", desc = " Play Recording" },
  },
  config = function()
    require("recorder").setup {
      slots = { "a", "b" },
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<C-q>",
        editMacro = "cq",
        yankMacro = "yq",
        addBreakPoint = "##",
      },

      -- Clears all macros-slots on startup.
      clear = false,

      -- Log level used for any notification, mostly relevant for nvim-notify.
      -- (Note that by default, nvim-notify does not show the levels trace & debug.)
      logLevel = vim.log.levels.INFO,

      -- Use nerdfont icons in the status bar components and keymap descriptions
      useNerdfontIcons = true,

      performanceOpts = {
        countThreshold = 100,
        lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
        noSystemClipboard = true, -- remove `+`/`*` from clipboard option
        autocmdEventsIgnore = { -- temporarily ignore these autocmd events
          "TextChangedI",
          "TextChanged",
          "InsertLeave",
          "InsertEnter",
          "InsertCharPre",
        },
      },

      -- [experimental] partially share keymaps with nvim-dap.
      -- (See README for further explanations.)
      dapSharedKeymaps = false,
    }
  end,
}
