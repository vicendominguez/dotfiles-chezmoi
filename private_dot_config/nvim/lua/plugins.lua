-- Easy config Plugins here
-- complex config Plugins in plugins/
return {
  { "folke/lazy.nvim", version = "*" },
  { "nvim-lualine/lualine.nvim", config = function() require("lualine").setup({options = { theme = "auto"}}) end },
  { "ibhagwan/fzf-lua", config = function() require("fzf-lua").setup() end },
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  { "nvim-tree/nvim-tree.lua", config = function() require("nvim-tree").setup() end },
  { "lukas-reineke/indent-blankline.nvim", config = function() require("ibl").setup() end },
  { 'echasnovski/mini.pairs', config = function () require("mini.pairs").setup() end, version = false },
}

