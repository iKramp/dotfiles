local lsp_zero = require('lsp-zero')
--[[
vim.g.rustaceanvim = function()
    local mason_repo = require('mason-registry')
    local codelldb = mason_repo.get_package('codelldb')
    local extension_path = codelldb:get_install_path() .. '/extension/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
    local cfg = require('rustaceanvim.config')

    return {
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
            capabilities = lsp_zero.get_capabilities()
        },
    }
end
]]
