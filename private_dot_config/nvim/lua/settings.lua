-- Opciones generales
vim.o.autowrite = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.laststatus = 2
vim.o.splitbelow = true
vim.o.splitright = true

-- Configuraciones específicas de Go
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_operators = 1
vim.g.go_fmt_autosave = 1
vim.g.go_fmt_command = "goimports"
vim.g.go_auto_type_info = 1
vim.o.updatetime = 100

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})
