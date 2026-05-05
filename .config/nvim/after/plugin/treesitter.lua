require('nvim-treesitter').install {
    'c',
    'lua',
    'vim',
    'rust',
    'nix',
    'markdown',
    'typescript',
    'javascript',
    'html',
    'css',
    'json',
    'toml',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end

    pcall(vim.treesitter.start)
  end,
})
