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
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

 {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      -- Ejecuta TSInstallSync go después de instalar o actualizar
      require("nvim-treesitter.install").update({ with_sync = true })("go")
      require("nvim-treesitter.install").update({ with_sync = true })("lua")
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go" }, -- Minimal install
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }, 
        indent = { enable = true },    -- Habilita indentación basada en treesitter
      })
    end,
  },
}

