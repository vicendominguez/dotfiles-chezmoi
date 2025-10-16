return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', config = true },
      'hrsh7th/cmp-nvim-lsp',
    },

    config = function()
      -- Get capabilities from nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Define on_attach function (used by go.lua)
      _G.on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- LSP navigation keymaps
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

        -- LSP action keymaps (the missing ones!)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)

        -- Diagnostic navigation
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)

        -- Enable inlay hints for Neovim 0.10+
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      -- Make capabilities global for go.lua
      _G.capabilities = capabilities

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim' } },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME }
              },
              telemetry = { enable = false },
            },
          },
        },
        -- Don't configure gopls here - let go.lua handle it
      }

      require('mason-tool-installer').setup {
        ensure_installed = { 'stylua', 'gofumpt', 'goimports' }
      }

      require('mason-lspconfig').setup {
        ensure_installed = { "lua_ls", "gopls" },
        automatic_installation = true,
      }

    end,
  },
}

