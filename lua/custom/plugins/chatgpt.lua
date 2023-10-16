local openapi_key = os.getenv("OPENAI_API_KEY")

if openapi_key == nil then
  print("OPENAI_API_KEY not set")
  return {}
end

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
