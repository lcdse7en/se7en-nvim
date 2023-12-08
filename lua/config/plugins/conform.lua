--********************************************
-- Author      : se7enlcd                    *
-- E-mail      : 2353442022@qq.com           *
-- Create_Time : 2023-12-08 16:11:43         *
-- Description :                             *
--********************************************

return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    local opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        rust = { 'rustfmt' },
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        scss = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        markdown = { { 'markdownlint', 'prettierd', 'prettier' } },
        json = { { 'jq', 'prettierd', 'prettier' } },
        proto = { { 'buf', 'protolint' } },
      },
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    }

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    local conform = require 'conform'

    conform.setup(opts)

    conform.formatters.rustfmt = {
      meta = {
        url = 'https://github.com/rust-lang/rustfmt',
        description = 'A tool for formatting rust code according to style guidelines.',
      },
      command = 'rustfmt',
      args = { '--emit=stdout', '--edition=2021' },
    }

    local function create_command(name, opts)
      if not opts then
        return
      end
      local command = opts.command
      opts.command = nil

      local subcommands = opts.subcommands
      opts.subcommands = nil
      if subcommands then
        opts.nargs = '*'

        local names = vim.tbl_keys(subcommands) --[[ @as string[] ]]

        function opts.complete(arg, line)
          local res = vim.api.nvim_parse_cmd(line, {})
          local argc = #res.args
          local first = false
          if argc == 0 then
            first = true
          end
          if argc == 1 and not line:match '%s$' then
            first = true
          end
          if first then
            local options = {}
            for _, option in ipairs(names) do
              if vim.startswith(option, arg) then
                table.insert(options, option)
              end
            end
            return options
          elseif argc == 2 or (argc == 1 and line:match '%s$') then
            local argval = vim.trim(res.args[1])
            if subcommands[argval] and subcommands[argval].complete then
              return subcommands[argval].complete(arg, line)
            end
          end
        end

        local execute = function(args)
          args = args.fargs
          local cmd = args[1]
          local function wrap(f, ...)
            local ok, e = pcall(f, ...)
            if not ok then
              vim.notify(e, vim.log.levels.WARN)
            end
          end
          if not cmd then
            if command then
              if type(command) == 'function' then
                wrap(command, args)
              else
                vim.api.nvim_exec2(command, { output = false })
              end
            else
              vim.notify('No subcommand specified', vim.log.levels.WARN)
            end
          elseif subcommands[cmd] then
            if type(subcommands[cmd].execute) == 'function' then
              wrap(subcommands[cmd].execute, unpack(args, 2))
            elseif type(subcommands[cmd].execute) == 'string' then
              ---@diagnostic disable-next-line: param-type-mismatch
              vim.api.nvim_exec2(subcommands[cmd].execute, {})
            end
          else
            vim.notify('Unknown subcommand ' .. cmd, vim.log.levels.WARN)
          end
        end

        vim.api.nvim_create_user_command(name, execute, opts)
        return
      end
      vim.api.nvim_create_user_command(name, command, opts)
    end

    create_command('Format', {
      desc = 'Manage foramtting',
      bang = true,
      command = function()
        require('conform').format {
          lsp_fallback = true,
        }
      end,
      subcommands = {
        disable = {
          execute = function()
            vim.g.disable_autoformat = true
          end,
        },
        enable = {
          execute = function()
            vim.g.disable_autoformat = false
          end,
        },
        toggle = {
          execute = function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
          end,
        },
      },
    })
  end,
}
