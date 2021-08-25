local ts_config = require('nvim-treesitter.configs')
ts_config.setup {
	highlight = {
		enable = true,
		use_languagetree = true
	},
	rainbow = {
		enable = true
	},
  indent = {
    enable = true,
  }
}
