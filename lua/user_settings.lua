PREF = {
	common = {
		textwidth = 100,
		tabwidth = 2,
		escape_keys = { 'jj', 'jk' },
	},

  lsp = {
    format_on_save = true,
    virtual_text = false,
    show_diagnostic = true,
    show_inlay_hints = true,
    -- Use take_over_mode for Vue projects or not
    tom_enable = false,
    preinstall_servers = {
      'pyright',
      'tsserver',
      'lua_ls',
      'html',
      'emmet_ls',
      'marksman',
      'cssls',
      'jsonls',
      'rust_analyzer',
      'sqlls',
      'bashls',
      'dockerls',
      'ltex',
    },
  },
	ui = {
		colorscheme = 'serenity',
    border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    italic_comment = true,
	},
  git = {
    show_blame = false,
    show_signcolumn = true,
  },
}