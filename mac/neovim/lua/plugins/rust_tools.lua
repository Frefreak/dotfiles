local present, rust_tools = pcall(require, "rust-tools")
if not present then
  return
end

local utils = require('utils')
local server = utils.load_rust_analyzer()
if server == nil then
    server = {}
end

server.on_attach = utils.on_attach

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

