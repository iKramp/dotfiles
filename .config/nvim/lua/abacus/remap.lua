vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'go to netrw file tree'})
vim.api.nvim_set_keymap('n', '<leader><F6>', '<cmd>!rm ~/.local/state/nvim/lsp.log<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', ';', '<cmd>FineCmdline<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})

vim.api.nvim_command("command W write")


