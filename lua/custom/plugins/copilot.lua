vim.keymap.set('n', '<leader>cct', function()
  vim.g.copilot_enabled = not vim.g.copilot_enabled
end, { desc = 'Copilot - Toggle' })

return {
  'github/copilot.vim',
  lazy = false, -- Load immediately
  config = function()
    -- Disable Copilot's default Tab mapping
    vim.g.copilot_enabled = false
    vim.g.copilot_no_tab_map = 1
    vim.g.copilot_settings = { selectedCompletionModel = 'gpt-4o-copilot' }
    -- vim.g.copilot_integration_id = 'vscode-chat'

    -- Map <M-l> (Alt + L) to accept Copilot suggestions
    vim.keymap.set('i', '<M-l>', 'copilot#Accept("<CR>")', {
      expr = true,
      silent = true,
      replace_keycodes = false,
      desc = 'Accept Copilot suggestion',
    })
  end,
}
