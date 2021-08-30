local utils = require('utils')
M = {}
function M.setup()
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
        on_attach = utils.on_attach,
        root_dir = vim.loop.cwd
    }
end
return M
