local builtin = require('telescope.builtin')
require('telescope').load_extension('live_grep_args')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find file' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'find in git' })
vim.keymap.set(
    'n',
    '<leader>fs',
    ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"
)
require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            'node_modules',
            '.git',
            'dist',
            'build/',
            'vendor',
            'coverage',
            'target',
            '*.pyc',
            '*.pyo',
            '*.pyd',
            '*.class',
            '*.o',
            '*.out',
            '*.exe',
            '*.dll',
        }
    }
})
