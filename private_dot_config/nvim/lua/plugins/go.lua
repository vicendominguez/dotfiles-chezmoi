-- Welcome GO 
return {
  {
  "ray-x/go.nvim",
  dependencies = {  
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("lspconfig").gopls.setup({
      cmd = { 'gopls' },
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      }
    })
    require("go").setup({
      lsp_inlay_hints = { enable = true }
    })
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod', 'gotmpl'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
}

