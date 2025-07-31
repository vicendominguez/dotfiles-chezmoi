return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local spinner_symbols = {
        "⢹", -- U+28B9
        "⢺", -- U+28BA
        "⢻", -- U+28BB
        "⢼", -- U+28BC
        "⣏", -- U+28CF
        "⣟", -- U+28DF
        "⣯", -- U+28EF
        "⣷", -- U+28FF
      }

      local spinner_symbols_len = #spinner_symbols
      local spinner_index = 1
      local processing = false

      local function update_spinner()
        if processing then
          spinner_index = (spinner_index % spinner_symbols_len) + 1
          return spinner_symbols[spinner_index]
        end
        return ""
      end

      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionRequest*",
        group = group,
        callback = function(event)
          if event.match == "CodeCompanionRequestStarted" then
            processing = true
          elseif event.match == "CodeCompanionRequestFinished" then
            processing = false
          end
          require("lualine").refresh()
        end,
      })

      local function codecompanion_current_model_name()
        if vim.g.codecompanion_in_use then
          local status, codecompanion = pcall(require, "codecompanion")
          if status and codecompanion and type(codecompanion.buf_get_chat) == "function" then
            local chat = codecompanion.buf_get_chat(vim.api.nvim_get_current_buf())
            if chat and chat.settings then
              return chat.settings.model or ""
            end
          end
        end
        return ""
      end

      require("lualine").setup({
        options = { theme = "auto" },
        sections = {
          lualine_c = { { 'filename', path = 1 } },
          lualine_y = { codecompanion_current_model_name, "progress" },
          lualine_z = { update_spinner, "location" },
        }
      })
    end
  },
}

