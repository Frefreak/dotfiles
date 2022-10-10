local M = {}

M.init = function(use)
    use 'vim-scripts/LargeFile'
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
        'mattn/emmet-vim',
        ft = {'html', 'javascript', 'php', 'css', 'vue', 'xml', 'svelte'}
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end,
        ft = {'css', 'html', 'svelte', 'js'}
    }

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    -- use 'ggandor/leap.nvim'
    use {
        'SirVer/ultisnips',
        config = function()
            vim.g.UltiSnipsEditSplit = "vertical"
            vim.g.UltiSnipsExpandTrigger = "<C-e>"
            vim.g.UltiSnipsListSnippets = "<C-l>"
            vim.api.nvim_command(
                'set runtimepath+=~/.local/share/nvim/site/pack/packer/start/vim-snippets')
        end
    }
    use 'honza/vim-snippets'
    use {'tpope/vim-fugitive', cmd = {"Git"}}
    use {
        'lervag/vimtex',
        ft = 'tex',
        config = function() vim.g.vimtex_compiler_method = 'tectonic' end
    }
    use {
        'terrortylor/nvim-comment',
        cmd = 'CommentToggle',
        config = function()
            require('nvim_comment').setup({comment_empty = false})
        end
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup({
                options = {theme = 'dracula'},
                sections = {
                    lualine_c = {'filename', "require'lsp-status'.status()"}
                }
            })
        end
    }

    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup({options = {diagnostics = 'nvim_lsp'}})
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-tree'.setup {
                update_cwd = true,
                renderer = {
                    icons = {
                        show = {
                            git = false,
                            folder = true,
                            file = false,
                            folder_arrow = true
                        }
                    },
                    highlight_git = false,
                },
            }
        end
    }

    use 'neovim/nvim-lspconfig'
    use 'tamago324/nlsp-settings.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'onsails/lspkind-nvim'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use {
        "ray-x/lsp_signature.nvim",
        config = function() require('lsp_signature').setup() end
    }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-lua/plenary.nvim'
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'simrat39/rust-tools.nvim'
    use {
        'nvim-lua/lsp-status.nvim',
        config = function()
            require('lsp-status').config({status_symbol = 'λ'})
            require('lsp-status').register_progress()
        end
    }
end

return M
