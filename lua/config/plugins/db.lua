return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_disable_progress_bar = 1
    vim.g.db_ui_use_postgres_views = 1
    vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_win_position = 'right'
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_execute_on_save = false

    vim.g.db_ui_save_location = '~/Dropbox/dbui'
    vim.g.db_ui_tmp_query_location = '~/code/queries'

    vim.g.db_ui_hide_schemas = { 'pg_toast_temp.*' }

    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_winwidth = 40
    vim.g.db_ui_notification_width = 36
    vim.g.db_ui_default_query = 'select * from "{table}" limit 10'

    vim.g.completion_matching_strategy_list = { 'exact', 'substring' }
    vim.g.completion_matching_ignore_case = 1
    vim.g.completion_use_svv = 1

    vim.keymap.set('n', '[s', '<Plug>(DBUI_GotoPrevSibling)')
    vim.keymap.set('n', ']s', '<Plug>(DBUI_GotoNextSibling)')
  end,
}
