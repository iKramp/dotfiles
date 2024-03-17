local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr, exclude = {'gs'}})
  vim.keymap.set({'n', 'x'}, 'gf', function()
    vim.lsp.buf.format({async = false, timeout_ms = 10000})
  end, opts)
end)

lsp_zero.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['rust_analyzer'] = {'rust'},
  }
})

lsp_zero.setup_servers({'clangd', 'rust_analyzer', 'lua_ls'})

lsp_zero.extend_cmp()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
--  mapping = cmp.mapping.preset.insert({
--    ['<C-Space>'] = cmp.mapping.complete(),
--    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--  }),
  mapping = {
    ['<C-Space>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.confirm({select = false})
      else
        cmp.complete()
      end
    end),
--    ['<C-e>'] = cmp.mapping.abort(), --find a good key for aborting
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
