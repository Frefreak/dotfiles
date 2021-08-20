M = {}
function M.setup(on_attach)
    require('lspconfig').efm.setup {
        init_options = {documentFormatting = true},
        settings = {
            languages = {
                python = {
                    {formatCommand = "black --fast -", formatStdin = true}
                },
                lua = {{formatCommand = "lua-format -i", formatStdin = true}}
            }
        },
        filetypes = {"python", "lua"},
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = vim.loop.cwd
    }
end
return M
