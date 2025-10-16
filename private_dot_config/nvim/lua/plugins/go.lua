-- Welcome GO 
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },

    opts = {
      lsp_cfg = false, -- Don't let go.nvim setup gopls, we handle it in lsp-config.lua
      lsp_gofumpt = true,
      lsp_on_attach = function(client, bufnr)
        -- Use our global on_attach function
        if _G.on_attach then
          _G.on_attach(client, bufnr)
        end
      end,
      lsp_inlay_hints = { enable = true },
      trouble = true,
      luasnip = true,
    },

    config = function(lp, opts)
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
       pattern = "*.go",
        callback = function()
        require('go.format').goimports()
        end,
        group = format_sync_grp,
    })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod', 'gotmpl'},
    build = ':lua require("go.install").update_all_sync()'
  },
}

