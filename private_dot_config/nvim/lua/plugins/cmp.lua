return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completions
      "hrsh7th/cmp-buffer",   -- Buffer completions
      "hrsh7th/cmp-path",     -- Path completions
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        -- Sources for autocompletion (removed luasnip since you don't use snippets)
        sources = cmp.config.sources({
          { name = 'lazydev', group_index = 0 },
          { name = "nvim_lsp" }, -- LSP completions (gopls for Go)
          { name = "buffer" },   -- Buffer words
          { name = "path" },     -- File paths
        }),
        
        -- Key mappings
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Esc>"] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        
        -- Completion behavior
        completion = {
          autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
        },
        experimental = {
          ghost_text = true, -- Shows "ghost" text of suggestion
        },
      })
    end,
  },
}
