 -- Run TSUpdate after installation or update
return {
  {
  "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   config = function()
     require("nvim-treesitter.configs").setup({
       ensure_installed = { "lua", "vim", "vimdoc", "query", "go" , "comment", "gotmpl" }, -- Minimal install
       sync_install = false,
       auto_install = true,
       highlight = {
         enable = true,
         additional_vim_regex_highlighting = false,
         disable = { "markdown" },
       }, 
       indent = { enable = true },    
     })
   end,
  },
}


