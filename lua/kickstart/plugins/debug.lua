-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
return {
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'


      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
          'debugpy',
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'DAP continue' })
      vim.keymap.set('n', '<leader>dn', dap.step_into, { desc = 'DAP step into' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'DAP step over' })
      vim.keymap.set('n', '<leader>db', dap.step_out, { desc = 'DAP step out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'DAP toggle breakpoint' })
      vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end)

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = "⏏",
          },
        },
      }
      -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
      vim.keymap.set("n", "<leader>du", dapui.toggle)

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup()
      local dap_python = require('dap-python')
      dap_python.setup()

      dap_python.test_runtest = 'pytest'
      dap_python.resolve_python = function()
        return ".venv/bin/python"
      end

      local dap_python_configs = dap.configurations.python
      table.insert(dap_python_configs, {
        name = 'Test Selected Test File',
        type = 'python',
        request = 'launch',
        module = "pytest",
        justMyCode = false,
        args = {
          "--runslow",
          "--randomly-dont-reset-seed",
          "--disable-warnings",
          "--ds=settings.test",
          "${file}",
        }
      })

      table.insert(dap_python_configs, {
        name = 'All Unit Test',
        type = 'python',
        request = 'launch',
        module = "pytest",
        justMyCode = false,
        args = {
          "--runslow",
          "--randomly-dont-reset-seed",
          "--disable-warnings",
          "--ds=settings.test",
          "--randomly-seed=560270402", -- Change on need
          "tests/unit",
        }
      })

      table.insert(dap_python_configs, {
        name = 'Django Run Server',
        type = 'python',
        request = 'launch',
        program = "manage.py",
        django = true,
        justMyCode = false,
        args = {
          "runserver",
          "--settings=settings.dev",
        }
      })
    end,
  }
}
