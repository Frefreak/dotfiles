local M = {}

M = {
    'ianding1/leetcode.vim',
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({filetypes = {gitcommit = true}})
        end
    },
    {'ray-x/go.nvim', ft = {'go'}},
    'vim-scripts/LargeFile',
    { 'Frefreak/gdscript-indent', ft = {'gdscript'} },
    {'dracula/vim', as = 'dracula'},
    'roxma/vim-tmux-clipboard',
    {
    'vimwiki/vimwiki',
        branch = 'dev',
        config = function()
            vim.g.vimwiki_list = {
                {path = '~/vimwiki/', index = 'index', ext = '.md'}
            }
            vim.g['vimwiki_global_ext'] = 0
        end
    },
    {
        'mattn/emmet-vim',
        ft = {'html', 'javascript', 'php', 'css', 'vue', 'xml', 'svelte'}
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end,
        ft = {'css', 'html', 'svelte', 'js'}
    },

    'tpope/vim-surround',
    'tpope/vim-repeat',
    'ggandor/leap.nvim',
    {
        'SirVer/ultisnips',
        init = function()
            vim.g.UltiSnipsEditSplit = "vertical"
            vim.g.UltiSnipsExpandTrigger = "<C-e>"
            vim.g.UltiSnipsListSnippets = "<C-l>"
            vim.api.nvim_command(
                'set runtimepath+=~/.local/share/nvim/lazy/vim-snippets')
        end
    },
    'honza/vim-snippets',
    {'tpope/vim-fugitive', cmd = {"Git"}},
    {
        'lervag/vimtex',
        ft = 'tex',
        config = function() vim.g.vimtex_compiler_method = 'tectonic' end
    },
    {
        'terrortylor/nvim-comment',
        cmd = 'CommentToggle',
        config = function()
            require('nvim_comment').setup({comment_empty = false})
        end
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = {"neovim/nvim-lspconfig"}
    },
    {
        'hoob3rt/lualine.nvim',
        dependencies = {{'kyazdani42/nvim-web-devicons', optional = true}},
        -- config = function()
        --     require('lualine').setup({
        --         options = {theme = 'dracula'},
        --         sections = {
        --             lualine_c = {'filename', "require'lsp-status'.status()"}
        --         }
        --     })
        -- end
    },

    {
        'akinsho/bufferline.nvim',
        dependencies = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require('bufferline').setup({options = {diagnostics = 'nvim_lsp'}})
        end
    },

    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {'kyazdani42/nvim-web-devicons'},
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
                    highlight_git = false
                }
            }
        end
    },

    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'onsails/lspkind-nvim',
    {
        "ray-x/lsp_signature.nvim",
        config = function() require('lsp_signature').setup() end
    },
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
        }
    },
    {'mrcjkb/rustaceanvim', ft = 'rust'},
    {
        'nvim-lua/lsp-status.nvim',
        config = function()
            require('lsp-status').config({status_symbol = 'λ'})
            require('lsp-status').register_progress()
        end
    },
    {
      'kaarmu/typst.vim',
      ft = 'typst',
      lazy=false,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            }
        },
    }
}

return M
