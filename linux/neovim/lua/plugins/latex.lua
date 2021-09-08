local utils = require('utils')
M = {}
function M.setup()
    require('lspconfig').latex.setup {
        settings = {
            latex = {
                build = {
                    args = {"-pdf", "-pdflatex=xelatex", "-interaction=nonstopmode", "-synctex=1", "%f"}
                }
            }
        },
        on_attach = utils.on_attach,
        root_dir = vim.loop.cwd
    }
end
return M
