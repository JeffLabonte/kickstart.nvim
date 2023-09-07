return {
  "AckslD/nvim-neoclip.lua",
  requires = {
    {"nvim-telescope/telescope.nvim"},
    {"kkharji/sqlite.lua", module = "sqlite"},
  },
  config = function()
    require("neoclip").setup({
      persistent_history = true,
    })
    require("telescope").load_extension("neoclip")

    vim.keymap.set('n', '<leader>sc', function()
      vim.cmd(":Telescope neoclip")
    end, { desc = '[S]earch [C]lipboard' })
  end,
}
