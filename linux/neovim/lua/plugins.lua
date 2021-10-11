return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {'dracula/vim', as = 'dracula'}
    use 'roxma/vim-tmux-clipboard'
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins.lspconfig')
        end
    }

    use {'kabouzeid/nvim-lspinstall', requires = {{'neovim/nvim-lspconfig'}}}

    use {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function() require('plugins.cmp') end
    }

    use {
        "hrsh7th/cmp-nvim-lsp",
        after = 'nvim-cmp',
    }
    use {
        "hrsh7th/cmp-buffer",
        after = 'nvim-cmp',
    }
    use {
        "quangnguyen30192/cmp-nvim-ultisnips",
        after = 'nvim-cmp',
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = {{'nvim-treesitter/nvim-treesitter'}}
    }
    use {
        'p00f/nvim-ts-rainbow',
        requires = {{'nvim-treesitter/nvim-treesitter'}}
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function() require('plugins.telescope-nvim') end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('plugins.nvimTree') end,
        requires = {{'kyazdani42/nvim-web-devicons'}}
    }

    use {
        'kyazdani42/nvim-web-devicons',
        config = function() require('plugins.icons') end
    }

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require('plugins/statusline') end
    }
    use {
        'akinsho/nvim-bufferline.lua',
        config = function() require('plugins/bufferline') end
    }

    use {
        'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {
                {path = '~/vimwiki/', index = 'index', ext = '.md'}
            }
        end
    }
    use {
        'justinmk/vim-sneak',
        config = function() vim.g['sneak#s_next'] = 1 end
    }
    use {
        'mattn/emmet-vim',
        ft = {'html', 'javascript', 'php', 'css', 'vue', 'xml', 'svelte'}
    }

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use {
        'SirVer/ultisnips',
        config = function()
            vim.g.UltiSnipsEditSplit = "vertical"
            vim.g.UltiSnipsSnippetDirectories = {
                "~/.local/share/nvim/UltiSnips/",
            }
            vim.g.UltiSnipsExpandTrigger = "<C-e>"
            vim.g.UltiSnipsListSnippets = "<C-l>"

            vim.api.nvim_command('set runtimepath+=~/.local/share/nvim/site/pack/packer/start/vim-snippets')
        end
    }
    use 'honza/vim-snippets'

    use {'tpope/vim-fugitive', cmd = {"Git"}}
    use {'lervag/vimtex', ft = 'tex', config = function()
        vim.g.vimtex_compiler_method = 'tectonic'
    end}
    use {
        'terrortylor/nvim-comment',
        cmd = {"CommentToggle"},
        config = function() require("plugins.others").comment() end
    }

    use {
        'simrat39/rust-tools.nvim',
        config = function() require('plugins.rust_tools') end
    }

    use { 'nvim-lua/lsp-status.nvim', config = function()
        require('lsp-status').register_progress()
    end }
end)
