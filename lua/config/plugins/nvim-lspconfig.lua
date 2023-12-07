return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPost" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "mason.nvim", lazy = true },
		{ "williamboman/mason.nvim", lazy = true },
		{ "williamboman/mason-lspconfig.nvim", lazy = true },
		{ "hrsh7th/nvim-cmp", lazy = true },
		{ "hrsh7th/cmp-nvim-lsp", lazy = true },
		{ "folke/neoconf.nvim", lazy = true },
		{
			"folke/neodev.nvim",
			ft = { "lua" },
			config = true,
		},
		--  NOTE: fidget
		{ "j-hui/fidget.nvim", lazy = true },
		{ "nvimdev/lspsaga.nvim", lazy = true },
		{ "b0o/SchemaStore.nvim", lazy = true },
	},
	servers = nil,
}
