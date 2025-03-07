return {
 {
   "olimorris/codecompanion.nvim",
   dependencies = {
     "nvim-lua/plenary.nvim",
     "nvim-treesitter/nvim-treesitter",
   },
   opts = {
      strategies = {
        chat = { adapter = 'ollama' },
        inline = { adapter = 'ollama' },
        adapters = {
           qwencoder = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "qwencoder", -- Give this adapter a different name to differentiate it from the default ollama adapter
              schema = {
                model = {
                  default = "qwen2.5-coder:7b",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
        },
      }
   } 
 },
}
