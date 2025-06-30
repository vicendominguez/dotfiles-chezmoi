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
      -- Setup gopls with your existing hints configuration
      require("lspconfig").gopls.setup({
        cmd = { 'gopls' },
        on_attach = _G.on_attach, -- Now defined in lsp-config.lua
        capabilities = _G.capabilities, -- Now defined in lsp-config.lua
        settings = {
          gopls = {
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        }
      })
      
      require("go").setup({
        lsp_inlay_hints = { enable = true },
        -- Disable go.nvim's LSP setup since we handle it above
        lsp_cfg = false,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod', 'gotmpl'},
    build = ':lua require("go.install").update_all_sync()'
  },
}

