local M = {}

M.init = function(use)
    use 'wbthomason/packer.nvim'
    use {'dracula/vim', as = 'dracula'}
    use 'roxma/vim-tmux-clipboard'
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
    use {'terrortylor/nvim-comment', cmd = 'CommentToggle',
        config = function() require('nvim_comment').setup({
            comment_empty = false,
        }) end
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('lualine').setup({
            options = {
                theme = 'dracula',
            },
            sections = {
                lualine_c = {'filename', require'lsp-status'.status},
            },
        }) end,
    }

    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup()
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            vim.g.nvim_tree_show_icons = {
              git = 0,
              folders = 1, -- or 0,
              files = 1, -- or 0,
              folder_arrows = 1 -- or 0
            }
            vim.g.nvim_tree_gitignore = 0
            vim.g.nvim_tree_git_hl = 0
            require'nvim-tree'.setup {
                update_focused_file = {
                  enable = true,
                  update_cwd = true,
               },
            }
        end
    }

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'onsails/lspkind-nvim'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use {
        "ray-x/lsp_signature.nvim",
        config = function() require('lsp_signature').setup() end,
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = {'nvim-treesitter/nvim-treesitter'}
    }
    use {
        'p00f/nvim-ts-rainbow',
        requires = {'nvim-treesitter/nvim-treesitter'}
    }
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'},
    }
    use 'simrat39/rust-tools.nvim'
    use { 'nvim-lua/lsp-status.nvim', config = function()
        require('lsp-status').register_progress()
    end }
end

return M
