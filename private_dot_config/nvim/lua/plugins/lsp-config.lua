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

      -- Define on_attach function (minimal - just for inlay hints)
      _G.on_attach = function(client, bufnr)
        print("on_attach running for " .. client.name .. " on buffer " .. bufnr)
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
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
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
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua',
          'gofumpt',
          'goimports',
          'golines',
          'gotests',
          'impl',
          'delve'
        }
      }

      require('mason-lspconfig').setup {
        ensure_installed = { "lua_ls", "gopls", "solargraph" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.on_attach = _G.on_attach
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

    end,
  },
}

