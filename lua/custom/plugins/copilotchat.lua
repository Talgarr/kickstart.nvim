-- Copilot Chat
-- Quick chat with Copilot
vim.keymap.set('n', '<leader>ccq', function()
  local input = vim.fn.input 'Quick Chat: '
  if input ~= '' then
    require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
  end
end, { desc = 'CopilotChat - Quick chat' })

-- vim.keymap.set('n', '<leader>ccm', function()
--     require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
-- end, { desc = 'CopilotChat - Change' })

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      model = 'gemini-2.5-pro',
    },
  },
}
