return {
  -- Gestor de plugins
  { "folke/lazy.nvim", version = "*" },

  -- Colorscheme
  { 
    "rebelot/kanagawa.nvim", 
    config = function() 
      require("kanagawa").setup()
      vim.cmd("colorscheme kanagawa")  -- Se carga después de configurar el plugin
    end 
  },

  -- Welcome GO 
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


  {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Fuente para LSP (necesaria para Go con gopls)
    "hrsh7th/cmp-buffer",   -- Fuente para palabras del buffer
    "hrsh7th/cmp-path",     -- Fuente para rutas del sistema
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      -- Fuentes de autocompletado
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Autocompletado desde LSP (gopls para Go)
        { name = "buffer" },   -- Palabras del buffer
        { name = "path" },     -- Rutas de archivo
      }),

      -- Mapeos de teclas
      mapping = {
        -- Abre el menú de autocompletado con Ctrl+Espacio
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Navega entre opciones con Ctrl+j y Ctrl+k
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Solo completa si seleccionas explícitamente
        -- Cierra el menú con Esc
        ["<Esc>"] = cmp.mapping.close(),
      },

      -- Comportamiento del autocompletado
      completion = {
        autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged }, -- Activa al escribir
      },
      experimental = {
        ghost_text = true, -- Muestra texto "fantasma" de la sugerencia (opcional)
      },
    })
  end,
  },

{
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false,
    })
    vim.keymap.set("n", "gS", require("treesj").toggle, { desc = "Toggle split/join" })
  end,
},

  -- Plugins
  { "nvim-lualine/lualine.nvim", config = function() require("lualine").setup() end },
  { "ibhagwan/fzf-lua", config = function() require("fzf-lua").setup() end },
  { "tpope/vim-fugitive" },
--  { "AndrewRadev/splitjoin.vim" },
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  { "nvim-tree/nvim-tree.lua", config = function() require("nvim-tree").setup() end },
  { "lukas-reineke/indent-blankline.nvim", config = function() require("ibl").setup() end },
}

