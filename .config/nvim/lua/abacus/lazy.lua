local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {'windwp/nvim-autopairs'},
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate' },
  { 'ThePrimeagen/harpoon' },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  { 'j-hui/fidget.nvim' },
  { 'VonHeikemen/fine-cmdline.nvim', dependencies = 'MunifTanjim/nui.nvim' },
  { 'numToStr/FTerm.nvim' },
  { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
  { 'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' }
})
