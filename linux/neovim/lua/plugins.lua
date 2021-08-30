return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {'dracula/vim', as = 'dracula'}
	use 'roxma/vim-tmux-clipboard'
	use {'neovim/nvim-lspconfig', config = function()
		require('plugins.lspconfig')
	end}
  use { "onsails/lspkind-nvim", event = "BufEnter", config = function()
    require("plugins.others").lspkind()
  end}
  use { "ray-x/lsp_signature.nvim", after = "nvim-lspconfig", config = function()
    require("plugins.others").signature()
  end }

	use {'kabouzeid/nvim-lspinstall', requires = {{'neovim/nvim-lspconfig'}}}

	use {"hrsh7th/nvim-compe", event = "InsertEnter", config = function()
		require('plugins.compe')
	end}

  use {'windwp/nvim-autopairs', after = 'nvim-compe', config = function()
    require('plugins.autopairs')
  end}

	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
		require('plugins.treesitter')
	end}
	use {'nvim-treesitter/nvim-treesitter-textobjects', requires = {{'nvim-treesitter/nvim-treesitter'}}}
	use {'p00f/nvim-ts-rainbow', requires = {{'nvim-treesitter/nvim-treesitter'}}}
	use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}, config = function()
		require('plugins.telescope-nvim')
	end}

	use {'kyazdani42/nvim-tree.lua', config = function()
		require('plugins.nvimTree')
	end, requires = {{'kyazdani42/nvim-web-devicons'}}}

  use {'kyazdani42/nvim-web-devicons', config = function()
    require('plugins.icons')
  end}

	use {'glepnir/galaxyline.nvim', branch = 'main', config = function()
		require('plugins/statusline')
	end}
	use {'akinsho/nvim-bufferline.lua', config = function()
		require('plugins/bufferline')
	end}

	use {'vimwiki/vimwiki', config = function()
		vim.g.vimwiki_list = {{path = '~/vimwiki/', index = 'index', ext = '.md'}}
	end}
	use {'justinmk/vim-sneak', config = function()
		vim.g['sneak#s_next'] = 1
	end}
	use {'mattn/emmet-vim', ft = {'html', 'javascript', 'php', 'css', 'vue', 'xml', 'svelte'}}

	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use {'SirVer/ultisnips', config = function()
		vim.g.UltiSnipsEditSplit = "vertical"
		vim.g.UltiSnipsSnippetDirectories = {"~/.local/share/nvim/UltiSnips/"}
		vim.g.UltiSnipsExpandTrigger = "<C-e>"
		vim.g.UltiSnipsListSnippets = "<C-l>"
	end}
	use 'honza/vim-snippets'

	use {'tpope/vim-fugitive', cmd = {"Git"}}
	use {'lervag/vimtex', ft = 'tex' }
	use {'terrortylor/nvim-comment', cmd = {"CommentToggle"}, config = function()
		require("plugins.others").comment()
	end}

  use {'simrat39/rust-tools.nvim', config = function()
      require('plugins.rust_tools')
  end}
end)
