local present, rust_tools = pcall(require, "rust-tools")
if not present then
  return
end

M = {}

function M.setup(on_attach)
    local utils = require('utils')
    local server = utils.load_rust_analyzer()
    if server == nil then
        server = {}
    end

    rust_tools.setup({
      tools = {
        autoSetHints = true,
        hover_with_actions = true,

        runnables = {
          use_telescope = true,
        },
        debuggables = {
          use_telescope = true
        },
        inlay_hints = {
          highlight = "InLayHints",
        },
        hover_actions = {
          auto_focus = true
        }
      },
      server = server,
    })

    require('lspconfig').rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = vim.loop.cwd,
        settings = server.settings,
    }
end

return M
