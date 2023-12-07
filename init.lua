vim.g.mapleader = ' '

require('user_settings')
require('options')
require('mappings')
require('autocmd')
require('Lazy')
require('utils')
require('config.colorscheme')
require('modules.thincc')
require('lsp.config')
require('lsp.setup')
require('lsp.functions')
require('lsp.autocmd')
