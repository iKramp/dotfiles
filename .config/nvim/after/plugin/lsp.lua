-- ─── Keymaps on attach ────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local function map(modes, lhs, rhs, desc)
            vim.keymap.set(modes, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Default LSP keymaps
        map('n', 'K',    vim.lsp.buf.hover,           'Hover docs')
        map('n', 'gd',   vim.lsp.buf.definition,      'Go to definition')
        map('n', 'gD',   vim.lsp.buf.declaration,     'Go to declaration')
        map('n', 'gi',   vim.lsp.buf.implementation,  'Go to implementation')
        map('n', 'go',   vim.lsp.buf.type_definition, 'Go to type definition')
        map('n', 'gs',   vim.lsp.buf.signature_help,  'Signature help')
        map('n', '<F2>', vim.lsp.buf.rename,           'Rename symbol')
        map({'n','x'}, '<F4>', vim.lsp.buf.code_action, 'Code action')
        map('n', 'gl',   vim.diagnostic.open_float,   'Open diagnostic float')
        map('n', '[d',   vim.diagnostic.goto_prev,    'Previous diagnostic')
        map('n', ']d',   vim.diagnostic.goto_next,    'Next diagnostic')

        -- gf → format buffer
        map({'n','x'}, 'gf', function()
            vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, 'Format buffer')

        -- gr → Telescope LSP references
        map('n', 'gr', '<cmd>Telescope lsp_references<cr>', 'LSP references (Telescope)')
    end,
})

-- ─── Format on save (Rust only) ───────────────────────────────────────────────
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.rs',
    callback = function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end,
})

-- ─── Capabilities for nvim-cmp ────────────────────────────────────────────────
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- jdtls needs its cmd path set manually (it's not on $PATH by default)
vim.lsp.config('jdtls', {
    cmd = { '/path/to/jdtls' },  -- adjust this
})
vim.lsp.enable('jdtls')

-- nil_ls: custom nixfmt formatter
vim.lsp.config('nil_ls', {
    settings = {
        ['nil'] = {
            formatting = {
                command = { 'nixfmt' },
            },
        },
    },
})

-- ─── Enable servers (nvim-lspconfig ships their configs, Neovim finds them) ───
vim.lsp.enable({
    'clangd', 'lua_ls', 'texlab', 'hls',
    'zls', 'eslint', 'ts_ls', 'html', 'cssls', 'qmlls', 'gopls',
    'nil_ls', 'jdtls',
})

local cmp = require('cmp')
local luasnip = require("luasnip")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noselect',
    },
    preselect = cmp.PreselectMode.None,      -- Disable automatic selection
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.confirm(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-z>'] = cmp.mapping.abort(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
})

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
