vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'go to netrw file tree'})
vim.api.nvim_set_keymap('n', '<leader><F6>', '<cmd>!rm ~/.local/state/nvim/lsp.log<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', ';', '<cmd>FineCmdline<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})

--paste
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true})

--copy
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>Y', '"+Y', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = true})

vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<nop>', {noremap = false})
vim.api.nvim_set_keymap('i', '<MiddleMouse>', '<nop>', {noremap = false})

vim.api.nvim_command("command W write")


