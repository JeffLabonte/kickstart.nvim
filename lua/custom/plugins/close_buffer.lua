return {
  "kazhala/close-buffers.nvim",
  config = function()
    vim.keymap.set("n", "<leader>ba", function()
      vim.cmd("Bdelete all")
    end, { desc = "Close all buffers" })

    vim.keymap.set("n", "<leader>bh", function ()
      vim.cmd("Bdelete hidden")
    end, { desc = "Close all hidden buffers" })
  end
}
