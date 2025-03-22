-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
require 'custom.plugins.go'

require 'custom.plugins.copilotchat'

require 'custom.plugins.vimtex'

require 'custom.plugins.piper'

require 'custom.plugins.lazygit'

require 'custom.plugins.csv'

-- Add reset view to middle when jumping
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Jump half a page up and center the view' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Jump half a page down and center the view' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Search for the next text and center the view.' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Search for the previous text and center the view.' })

return {
  'brenoprata10/nvim-highlight-colors',
}
