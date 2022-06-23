local M = {}

--require'lspconfig'.golangci_lint_ls.setup{
--    init_options = {
--      command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json", 
--            "--disable", "structcheck"
--        }
--    }
--}

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
