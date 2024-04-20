local lsp_zero = require('lsp-zero')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false
    })
    vim.keymap.set({ 'n', 'x' }, 'gf', function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end, { desc = 'format buffer' })
end)

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['rust_analyzer'] = { 'rust' },
    }
})


lsp_zero.setup_servers({ 'clangd', 'lua_ls' })

lsp_zero.configure('rust_analyzer', {
    single_file_support = true,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            procMacro = {
                enable = true
            },
        },
    },
})

lsp_zero.extend_cmp()

local cmp = require('cmp')
local luasnip = require("luasnip")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.confirm(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-z>'] = cmp.mapping.abort(),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
