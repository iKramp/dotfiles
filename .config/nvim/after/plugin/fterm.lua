require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
    blend = 25,
})

-- Example keybindings
vim.keymap.set('n', '<leader>ft', '<CMD>lua require("FTerm").toggle()<CR>', { desc = 'toggle a floating terminal' })
vim.keymap.set('t', '<leader>ft', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { desc = 'toggle a floating terminal' } )
