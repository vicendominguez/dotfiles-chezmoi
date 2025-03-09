return {
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
        { name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
        { name = "nvim_lsp" }, -- Autocompletado desde LSP (gopls para Go)
        { name = "buffer" },   -- Palabras del buffer
        { name = "path" },     -- Rutas de archivo
        { name = 'luasnip' },
      }),

      -- Mapeos de teclas
      mapping = {
        -- Abre el menú de autocompletado con Ctrl+Espacio
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Esc>"] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
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
}
