-- typos
vim.api.nvim_create_user_command("WQ", "wq", { bang = true }) -- Soporta WQ!
vim.api.nvim_create_user_command("Wq", "wq", { bang = true }) -- Soporta Wq!
vim.api.nvim_create_user_command("W", "w", { bang = true })  -- Soporta W!
vim.api.nvim_create_user_command("Q", "q", { bang = true })  -- Soporta Q!
vim.api.nvim_create_user_command("Qa", "qa", { bang = true }) -- Soporta Qa!
vim.api.nvim_create_user_command("QA", "qa", { bang = true }) -- Soporta QA!

-- Mappings para Go (usando ray-x/go.nvim)
-- Mapeos para ray-x/go.nvim
-- Prefijo: <leader>g para comandos relacionados con Go
local map = vim.keymap.set
map("n", "<leader>gr", ":GoRun<CR>", { desc = "Run Go file" }) -- Ejecutar el archivo actual
map("n", "<leader>gb", ":GoBuild<CR>", { desc = "Build Go file" }) -- Compilar el archivo actual
map("n", "<leader>gt", ":GoTest<CR>", { desc = "Run all tests in file" }) -- Ejecutar pruebas del archivo
map("n", "<leader>gT", ":GoTestFunc<CR>", { desc = "Run test under cursor" }) -- Ejecutar la prueba bajo el cursor
map("n", "<leader>gc", ":GoCoverage<CR>", { desc = "Show test coverage" }) -- Mostrar cobertura de pruebas
map("n", "<leader>gf", ":GoFmt<CR>", { desc = "Format file with gofmt" }) -- Formatear con gofmt
map("n", "<leader>gi", ":GoImport<CR>", { desc = "Run goimports" }) -- Ejecutar goimports
map("n", "<leader>ga", ":GoAddTag<CR>", { desc = "Add struct tags" }) -- Añadir tags a structs
map("n", "<leader>ge", ":GoIfErr<CR>", { desc = "Generate if err != nil" }) -- Generar bloque if err
map("n", "<leader>gd", ":GoDoc<CR>", { desc = "Show documentation under cursor" }) -- Mostrar documentación
map("n", "<leader>gn", ":GoRename<CR>", { desc = "Rename symbol under cursor" }) -- Renombrar símbolo

-- Navegación con LSP (usando funciones de go.nvim o LSP nativo)
local lsp_split_right = function(action)
  return function()
    local original_win = vim.api.nvim_get_current_win()
    vim.cmd("vsplit")
    local new_win = vim.api.nvim_get_current_win()
    action()
    if vim.api.nvim_get_current_win() == original_win then
      vim.api.nvim_win_close(new_win, true)
    end
  end
end

map("n", "<leader>gg", lsp_split_right(vim.lsp.buf.definition), { desc = "Go to definition (vsplit right)" })
map("n", "<leader>gi", lsp_split_right(vim.lsp.buf.implementation), { desc = "Go to implementation (vsplit right)" })
map("n", "<leader>gR", "<cmd>lua vim.lsp.buf.references({ loclist = false, popup = true })<CR>", { desc = "List references (popup)" })

-- Depuración (si usas DAP con go.nvim)
map("n", "<leader>ds", ":GoDebug<CR>", { desc = "Start Go debugger" })
map("n", "<leader>db", ":GoBreakToggle<CR>", { desc = "Toggle breakpoint" })

-- Mappings para FZF
map("n", "<C-p>", ":FzfLua files<CR>", { silent = true })
map("n", "<leader>f", ":FzfLua grep<CR>", { silent = true })
map("n", "<leader>g", ":FzfLua git_commits<CR>", { silent = true })
map("n", "<leader>h", ":FzfLua oldfiles<CR>", { silent = true })

-- Mappings para NvimTree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })
map("n", "<leader>t", ":NvimTreeFindFile<CR>", { silent = true })
