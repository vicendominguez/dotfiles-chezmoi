-- Configuración básica
vim.g.mapleader = " "  -- Define el líder como espacio
vim.opt.number = true  -- Mostrar números de línea
vim.opt.tabstop = 2    -- Tamaño de tabulación
vim.opt.shiftwidth = 2 -- Tamaño de indentación
vim.opt.expandtab = true -- Usar espacios en lugar de tabs
vim.opt.splitbelow = true -- Dividir ventanas hacia abajo
vim.opt.splitright = true -- Dividir ventanas hacia la derecha
vim.opt.laststatus = 2 -- Mostrar la barra de estado siempre
vim.opt.updatetime = 100 -- Tiempo de actualización para plugins

-- Instalar lazy.nvim si no está instalado
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

-- Configuración de plugins con lazy.nvim
require("lazy").setup({
  -- Gestor de plugins
  {
    "folke/lazy.nvim",
    lazy = false, -- Cargar inmediatamente
  },

  -- Tema molokai
  {
    "fatih/molokai",  -- Tema molokai
    lazy = false,  -- Cargar inmediatamente
    config = function()
      vim.cmd('colorscheme molokai')  -- Aplicar el tema después de cargar el plugin
    end,
  },

  -- Plugins de Vim migrados
  {
    "fatih/vim-go",  -- Soporte para Go
    ft = "go",  -- Cargar solo para archivos Go
  },
  {
    "vim-airline/vim-airline",  -- Barra de estado
    lazy = false,  -- Cargar inmediatamente
    config = function()
      -- Configuración de vim-airline en Lua
      vim.g.airline = {
        extensions = {
          tabline = {
            enabled = 1,  -- Habilitar la línea de pestañas
            fnamemod = ":t",  -- Mostrar solo el nombre del archivo
          },
        },
      }
    end,
  },
  {
    "junegunn/fzf",  -- FZF
    build = ":call fzf#install()",  -- Instalar dependencias
  },
  {
    "junegunn/fzf.vim",  -- Integración de FZF con Vim
    dependencies = { "junegunn/fzf" },
  },
  {
    "tpope/vim-fugitive",  -- Integración con Git
    cmd = { "G", "Git" },  -- Cargar solo cuando se usen comandos de Git
  },
  {
    "AndrewRadev/splitjoin.vim",  -- Dividir y unir código
    keys = { "gJ", "gS" },  -- Cargar solo al usar atajos
  },
  {
    "preservim/nerdcommenter",  -- Comentarios
    keys = { "<leader>c", "<leader>cs" },  -- Cargar solo al usar atajos
  },
  {
    "preservim/nerdtree",  -- Explorador de archivos
    keys = { "<C-n>", "<leader>t" },  -- Cargar solo al usar atajos
  },
  {
    "ervandew/supertab",  -- Autocompletado con Tab
    event = "InsertEnter",  -- Cargar al entrar en modo inserción
  },

  -- Plugins recomendados para Neovim
  {
    "nvim-telescope/telescope.nvim",  -- Alternativa moderna a FZF
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { "<leader>ff", "<leader>fg", "<leader>fb" },  -- Cargar solo al usar atajos
  },
  {
    "neovim/nvim-lspconfig",  -- Configuración del LSP
    event = "BufReadPre",  -- Cargar al abrir un archivo
  },
  {
    "hrsh7th/nvim-cmp",  -- Autocompletado moderno
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- Fuente de autocompletado para LSP
    },
    event = "InsertEnter",  -- Cargar al entrar en modo inserción
  },
})

-- Configuración de vim-go
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_operators = 1
vim.g.go_fmt_autosave = 1
vim.g.go_fmt_command = "goimports"
vim.g.go_auto_type_info = 1

-- Atajos de teclado
vim.api.nvim_set_keymap('n', '<leader>b', ':lua require("go").build()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':GoRun<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':GoTest<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':GoCoverageToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>i', ':GoInfo<CR>', { noremap = true })

-- Configuración de FZF
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Rg<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>g', ':Commits<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':History<CR>', { noremap = true })

-- Configuración de NERDTree
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':NERDTreeFind<CR>', { noremap = true })
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeIgnore = { '\\.git$', 'node_modules$', '\\.nyc_output$' }  -- Barras invertidas escapadas

-- Configuración de Telescope (alternativa a FZF)
require('telescope').setup({})
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true })
