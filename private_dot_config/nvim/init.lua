local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Última versión estable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Workaround para bug Treesitter + Neovim 0.12.3 con markdown
-- Desactivar ftplugin de markdown que intenta usar Treesitter
vim.g.did_load_filetypes = 1
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.b.did_ftplugin = 1
  end,
})

-- Cargar los plugins
require("settings")
require("mappings")
require("lazy").setup("plugins")



