return {
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set('n', '<leader>gg', function()
        vim.cmd("LazyGit")
      end, { desc = 'Lazy Git Open' })
    end,
  }
}
