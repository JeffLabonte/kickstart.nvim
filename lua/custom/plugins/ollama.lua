return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
      { 'nvim-lua/plenary.nvim' },
      { 'hrsh7th/nvim-cmp' },
    },
    opts = {
      --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://jflabonte-tower:11434',
            },
            adapter = 'ollama',
            schema = {
              model = {
                default = 'gemma3',
              },
            },
          })
        end,
      },
      opts = {
        log_level = 'DEBUG',
      },
      strategies = {
        --NOTE: Change the adapter as required
        chat = { adapter = 'ollama' },
        inline = { adapter = 'ollama' },
        agent = { adapter = 'ollama' },
      },
    },
  },
}
