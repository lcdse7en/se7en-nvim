return {
  {
    'linux-cultist/venv-selector.nvim',
    opts = {
      -- 支持在 venv 和 .venv 目录名中查找 Python Virtualenv
      name = { 'venv', '.venv' },
      auto_refresh = true,
    },
  },
}
