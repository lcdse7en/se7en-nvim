return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  cmd = { "YankyRingHistory" },
  dependencies = {
    "kkharji/sqlite.lua",
  },
  config = function()
    require("yanky").setup({
      ring = {
        history_length = 50,
        --- Using shada, this will save pesistantly using Neovim ShaDa feature. This means that history will be persisted between each session of Neovim.
        --- Using memory, each Neovim instance will have his own history and il will be lost between sessions
        --- If you want to use sqlite as storage, you must add kkharji/sqlite.lua as dependency:
        storage = "sqlite",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
        sync_with_numbered_registers = true,
        cancel_event = "update",
      },
      picker = {
        select = {
          action = nil, -- nil to use default put action
        },
        telescope = {
          use_default_mappings = true, -- if default mappings should be used
          mappings = nil,              -- nil to use default mappings or no mappings (see `use_default_mappings`)
        },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
      },
      preserve_cursor_position = {
        enabled = false,
      },
    })

    vim.keymap.set({ "n", "x" }, "<leader>y", "<Plug>(YankyPutAfter)", { desc = "yanky after" })
    vim.keymap.set({ "n", "x" }, "<leader>Y", "<Plug>(YankyPutBefore)", { desc = "yanky before" })
    vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
    vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
    -- cycle through the yank history, only work after paste
    vim.keymap.set("n", "[y", "<Plug>(YankyCycleForward)")
    vim.keymap.set("n", "]y", "<Plug>(YankyCycleBackward)")
  end,
}
