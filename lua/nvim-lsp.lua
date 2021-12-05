local M = {}

function M.disable_nvim_lsp_diagnostics()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text=false,
            underline=false,
            update_in_insert=false,
            signs=false
        }
    )
end


return M
