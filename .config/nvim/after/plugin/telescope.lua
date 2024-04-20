local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find file' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'find in git' })
vim.keymap.set(
    'n',
    '<leader>fs',
    function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end,
    { desc = 'find a string in file' }
)
