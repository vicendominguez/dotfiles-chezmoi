return {
  -- Colorscheme
  { 
    "rebelot/kanagawa.nvim", 
    config = function() 
      require("kanagawa").setup()
      vim.cmd("colorscheme kanagawa")  -- Se carga después de configurar el plugin
    end 
  },
}
