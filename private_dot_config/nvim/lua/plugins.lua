-- Easy config Plugins here
-- complex config Plugins in plugins/
return {
  { "folke/lazy.nvim", version = "*" },
  { "ibhagwan/fzf-lua", config = function() require("fzf-lua").setup() end },
  { "nvim-tree/nvim-tree.lua", config = function() require("nvim-tree").setup() end },
  { "lukas-reineke/indent-blankline.nvim", config = function() require("ibl").setup() end },
  { "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
      require("mini.splitjoin").setup()
      require("mini.hipatterns").setup()
      require("mini.git").setup()
    end,
  },
}

