return {
  'hrsh7th/nvim-cmp',
  enabled = true,
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'lukas-reineke/cmp-under-comparator',
    'lukas-reineke/cmp-rg',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  },
  config = function()
		local lspkind = require "lspkind"
		local types = require "cmp.types"

		local _, tabnine = pcall(require, "cmp_tabnine.config")

		local cmp_status_ok, cmp = pcall(require, "cmp")
		if not cmp_status_ok then
			P "Failed to load cmp"
			return
		end

		local snip_status_ok, luasnip = pcall(require, "luasnip")
		if not snip_status_ok then
			P "Failed to load luasnip"
			return
		end

		local cmp_git_ok, cmp_git = pcall(require, "cmp_git")
		if not cmp_git_ok then
			P "Failed to load cmp_git"
			return
		end

		cmp_git.setup()

		local copilot_comparators_status_ok, copilot_cmp_comparators = pcall(require, "copilot_cmp.comparators")
		if not copilot_comparators_status_ok then
			P "Failed to load copilot_cmp.comparators"
			return
		end

		--  NOTE: Luasnippet
		require("luasnip.loaders.from_lua").load {
			paths = {
				"~/.config/nvim/lua/snippets/",
			},
		}
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_snipmate").lazy_load {
			paths = { "./snips/" },
		}

		local auto_expand = require("luasnip").expand_auto
		require("luasnip").expand_auto = function(...)
			vim.o.undolevels = vim.o.undolevels
			auto_expand(...)
		end

		require("luasnip").config.set_config {
			history = true, --  NOTE: keep around last snippet local to jump back
			updateevents = "TextChanged,TextChangedI", --  NOTE: update changes as you type (when using function)
			region_check_events = "CursorMoved, CursorHold, InsertEnter",
			delete_check_events = "TextChanged,InsertLeave",
			enable_autosnippets = true,
			store_selection_keys = "`",
			ext_opts = {
				[require("luasnip.util.types").choiceNode] = {
					active = { virt_text = { { "●", "DevIconCoffee" } } },
					passive = { virt_text = { { "●", "DevIconIni" } } },
					sign = { "LuaSnipChoiceListSelections" },
				},
				[require("luasnip.util.types").insertNode] = {
					active = { virt_text = { { "●", "DevIconOPUS" } } },
					passive = { virt_text = { { "●", "DevIconDefault" } } },
				},
				[require("luasnip.util.types").dynamicNode] = {
					active = { virt_text = { { "●", "DevIconSln" } } },
					passive = { virt_text = { { "●", "DevIconDefault" } } },
				},
			},
		}

		vim.api.nvim_set_keymap(
			"i",
			"<c-h>",
			'luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<c-h>"',
			{ expr = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"s",
			"<c-h>",
			'luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<c-h>"',
			{ expr = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"i",
			"<c-l>",
			'luasnip#choice_active() ? "<Plug>luasnip-prev-choice" : "<c-l>"',
			{ expr = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"s",
			"<c-l>",
			'luasnip#choice_active() ? "<Plug>luasnip-prev-choice" : "<c-l>"',
			{ expr = true, silent = true }
		)

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Utils                                                    │
		-- ╰──────────────────────────────────────────────────────────╯
		local check_backspace = function()
			local col = vim.fn.col "." - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
		end

		local function deprioritize_snippet(entry1, entry2)
			if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return false
			end
			if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return true
			end
		end

		local function limit_lsp_types(entry, ctx)
			local kind = entry:get_kind()
			local line = ctx.cursor.line
			local col = ctx.cursor.col
			local char_before_cursor = string.sub(line, col - 1, col - 1)
			local char_after_dot = string.sub(line, col, col)

			if char_before_cursor == "." and char_after_dot:match "[a-zA-Z]" then
				if
					kind == types.lsp.CompletionItemKind.Method
					or kind == types.lsp.CompletionItemKind.Field
					or kind == types.lsp.CompletionItemKind.Property
				then
					return true
				else
					return false
				end
			elseif string.match(line, "^%s+%w+$") then
				if kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable then
					return true
				else
					return false
				end
			end

			return true
		end

		local has_words_before = function()
			if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
				return false
			end
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
		end

		--- Get completion context, i.e., auto-import/target module location.
		--- Depending on the LSP this information is stored in different parts of the
		--- lsp.CompletionItem payload. The process to find them is very manual: log the payloads
		--- And see where useful information is stored.
		---@param completion lsp.CompletionItem
		---@param source cmp.Source
		---@see Astronvim, because i just discovered they're already doing this thing, too
		--  https://github.com/AstroNvim/AstroNvim
		local function get_lsp_completion_context(completion, source)
			local ok, source_name = pcall(function()
				return source.source.client.config.name
			end)
			if not ok then
				return nil
			end
			if source_name == "tsserver" or source_name == "typescript-tools" then
				return completion.detail
			elseif source_name == "pyright" then
				if completion.labelDetails ~= nil then
					return completion.labelDetails.description
				end
			end
		end

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Setup                                                    │
		-- ╰──────────────────────────────────────────────────────────╯
		local source_mapping = {
			npm = Se7enVim.icons.terminal .. "NPM",
			cmp_tabnine = Se7enVim.icons.light,
			Copilot = Se7enVim.icons.copilot,
			Codeium = Se7enVim.icons.codeium,
			nvim_lsp = Se7enVim.icons.paragraph .. "LSP",
			buffer = Se7enVim.icons.buffer .. "BUF",
			nvim_lua = Se7enVim.icons.bomb .. "api",
			luasnip = Se7enVim.icons.snippet .. "SNP",
			calc = Se7enVim.icons.calculator,
			path = Se7enVim.icons.folderOpen2 .. "Path",
			treesitter = Se7enVim.icons.tree .. "Tree",
			zsh = Se7enVim.icons.terminal .. "ZSH",
			look = Se7enVim.icons.paragraph .. "LOOK",
		}

		local buffer_option = {
			-- Complete from all visible buffers (splits)
			get_bufnrs = function()
				local bufs = {}
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					bufs[vim.api.nvim_win_get_buf(win)] = true
				end
				return vim.tbl_keys(bufs)
			end,
		}

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				["<Up>"] = cmp.mapping.select_prev_item(),
				["<Down>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				["<C-e>"] = cmp.mapping {
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				},
				["<CR>"] = cmp.mapping.confirm {
					-- this is the important line for Copilot
					behavior = cmp.ConfirmBehavior.Replace,
					select = Se7enVim.plugins.completion.select_first_on_enter,
				},
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif copilot.is_visible() then
						copilot.accept()
					elseif cmp.visible() and has_words_before() then
						cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif check_backspace() then
						fallback()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<C-j>"] = cmp.mapping(function(fallback)
					if luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<C-k>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			},

			formatting = {
				format = function(entry, vim_item)
					-- Set the highlight group for the Codeium source
					if entry.source.name == "codeium" then
						vim_item.kind_hl_group = "CmpItemKindCopilot"
					end

					-- Get the item with kind from the lspkind plugin
					local item_with_kind = require("lspkind").cmp_format {
						mode = "symbol_text", -- symbol | symbol_text | text_symbol
						maxwidth = 50,
						-- preset = "codicons",
						-- symbol_map = source_mapping,
						symbol_map = {
							Text = "",
							Method = "",
							Function = "",
							Constructor = "",
							Field = "ﰠ",
							Variable = "",
							Class = "ﴯ",
							Interface = "",
							Module = "",
							Property = "ﰠ",
							Unit = "塞",
							Value = "",
							Enum = "",
							Keyword = "",
							Snippet = "",
							Color = "",
							File = "",
							Reference = "",
							Folder = "",
							EnumMember = "",
							Constant = "",
							Struct = "פּ",
							Event = "",
							Operator = "",
							TypeParameter = "",
						},
					}(entry, vim_item)

					item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
					item_with_kind.menu = source_mapping[entry.source.name]
					item_with_kind.menu = vim.trim(item_with_kind.menu or "")
					item_with_kind.abbr = string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)

					if entry.source.name == "cmp_tabnine" then
						if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
							item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. " TabNine"
							item_with_kind.menu = item_with_kind.menu .. entry.completion_item.data.detail
						else
							item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. " TabNine"
							item_with_kind.menu = item_with_kind.menu .. " TBN"
						end
					end

					local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
					if completion_context ~= nil and completion_context ~= "" then
						item_with_kind.menu = item_with_kind.menu .. [[ -> ]] .. completion_context
					end

					if string.find(vim_item.kind, "Color") then
						-- Override for plugin purposes
						vim_item.kind = "Color"
						local tailwind_item = require("cmp-tailwind-colors").format(entry, vim_item)
						item_with_kind.menu = lspkind.symbolic("Color", { with_text = false }) .. " Color"
						item_with_kind.kind = " " .. tailwind_item.kind
					end

					return item_with_kind
				end,
			},

			-- You should specify your *installed* sources.
			sources = {
				{
					name = "nvim_lsp",
					priority = 10,
					-- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
					entry_filter = limit_lsp_types,
				},
				{ name = "npm", priority = 9 },
				-- { name = "codeium", priority = 9 },
				-- { name = "copilot", priority = 9 },
				{ name = "git", priority = 7 },
				-- { name = "cmp_tabnine", priority = 7, max_num_results = 3 },
				{ name = "luasnip", priority = 7, max_item_count = 5 },
				{ name = "buffer", priority = 7, keyword_length = 3, option = buffer_option, max_item_count = 10 },
				{ name = "Color", priority = 6 },
				{ name = "nvim_lua", priority = 5 },
				{ name = "path", priority = 4 },
				{ name = "calc", priority = 3 },
				{
					name = "look",
					priority = 2,
					keyword_length = 3,
					option = {
						convert_case = true,
						loud = true,
						dict = "/home/se7en/dotfiles/dict",
					},
				},
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					deprioritize_snippet,
					copilot_cmp_comparators.prioritize or function() end,
					cmp.config.compare.exact,
					cmp.config.compare.locality,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.offset,
					cmp.config.compare.sort_text,
					cmp.config.compare.order,
				},
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				completion = cmp.config.window.bordered {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
				documentation = cmp.config.window.bordered {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			experimental = {
				ghost_text = true,
			},
			performance = {
				max_view_entries = 100,
			},
		}

		-- ╭──────────────────────────────────────────────────────────╮
		-- │ Tabnine Setup                                            │
		-- ╰──────────────────────────────────────────────────────────╯
		if Se7enVim.plugins.ai.tabnine.enabled then
			tabnine:setup {
				max_lines = 1000,
				max_num_results = 3,
				sort = true,
				show_prediction_strength = true,
				run_on_every_keystroke = true,
				snipper_placeholder = "..",
				ignored_file_types = {},
			}
		end
	end
}