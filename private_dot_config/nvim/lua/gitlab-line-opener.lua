--[[
  A simple Neovim plugin to open the current line in GitLab.
  
  To install this plugin, save this file as `gitlab-line-opener.lua` in your Neovim configuration directory, for example, in `~/.config/nvim/lua/`.
  
  Then, you can add the following to your `init.lua` to configure and map a key to open the current line in GitLab:
  
  -- In your init.lua
  -- Configure your GitLab URL
  vim.g.gitlab_url = "https://gitlab.yourcompany.com"

  -- Map a key to open the GitLab link
  vim.api.nvim_set_keymap('n', '<leader>gl', '<cmd>lua require("gitlab-line-opener").open_line_in_gitlab()<cr>', { noremap = true, silent = true })

]]

vim.g.gitlab_url = os.getenv("GITLAB_ADDR")

local M = {}

function M.open_line_in_gitlab()
  -- Get the GitLab URL from the global configuration
  local gitlab_url = vim.g.gitlab_url
  if not gitlab_url then
    print("Error: GitLab URL is not configured. Please set vim.g.gitlab_url in your init.lua")
    return
  end

  -- Get the current file path
  local file_path = vim.fn.expand('%:p')
  if not file_path or file_path == '' then
    print("Error: Could not get the current file path.")
    return
  end

  -- Get the current line number
  local line_number = vim.fn.line('.')

  -- Get the Git repository's root directory
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print("Error: Not a Git repository.")
    return
  end

  -- Get the remote URL
  local remote_url = vim.fn.systemlist('git remote get-url origin')[1]
  if vim.v.shell_error ~= 0 then
    print("Error: Could not get the remote URL.")
    return
  end

  -- Get the current branch name
  local branch_name = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')[1]
  if vim.v.shell_error ~= 0 then
    print("Error: Could not get the current branch name.")
    return
  end

  -- Construct the relative file path from the Git root
  local relative_file_path = file_path:sub(#git_root + 2)

  -- Extract the project path from the remote URL
  local project_path = remote_url:match(":(.*)%.git")
  if not project_path then
    print("Error: Could not parse the project path from the remote URL.")
    return
  end

  -- Construct the final GitLab URL
  local url = string.format("%s/%s/-/blob/%s/%s#L%d", gitlab_url, project_path, branch_name, relative_file_path, line_number)

  -- Open the URL in the default browser
  -- The `open` command is specific to macOS
  local command = string.format("open '%s'", url)
  os.execute(command)
end

return M

