--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 13:06:39         *
-- Description :                             *
--********************************************

vim.g.mapleader = ' '

require('se7en_settings')
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
require('utils.globals')
require('utils.FloatWin')
require('utils.CodeRunning')
require('vm.vmlens')
