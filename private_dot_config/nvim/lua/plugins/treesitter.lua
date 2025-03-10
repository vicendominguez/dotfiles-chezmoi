 -- Run TSInstallSync go after installation or update
return {
  {
  "nvim-treesitter/nvim-treesitter",
   build = function()
     require("nvim-treesitter.install").update({ with_sync = true })("go")
     require("nvim-treesitter.install").update({ with_sync = true })("lua")
     require("nvim-treesitter.install").update({ with_sync = true })("vim")
     require("nvim-treesitter.install").update({ with_sync = true })("vimdoc")
     require("nvim-treesitter.install").update({ with_sync = true })("gotmpl")
     require("nvim-treesitter.install").update({ with_sync = true })("comment")
     require("nvim-treesitter.install").update({ with_sync = true })("json")
   end,
   config = function()
     require("nvim-treesitter.configs").setup({
       ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go" , "comment", "gotmpl" }, -- Minimal install
       sync_install = false,
       auto_install = true,
       highlight = {
         enable = true,
         additional_vim_regex_highlighting = false,
       }, 
       indent = { enable = true },    
     })
   end,
  },
}


