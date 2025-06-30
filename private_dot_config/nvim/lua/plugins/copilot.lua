-- Copilot plugin - only loaded on macOS
local function is_darwin()
  return vim.loop.os_uname().sysname == "Darwin"
end

if not is_darwin() then
  return {}
end

return {
  {
    'github/copilot.vim',
    config = function()
      -- Copilot specific configuration here if needed
      -- vim.g.copilot_no_tab_map = true
      -- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end
  }
}
