local M = {}

M = {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({ filetypes = { gitcommit = true } })
        end
    },
    'wellle/targets.vim',
    { 'ray-x/go.nvim',            ft = { 'go' } }, 'vim-scripts/LargeFile',
    { 'Frefreak/gdscript-indent', ft = { 'gdscript' } },
    { 'dracula/vim',              as = 'dracula' }, 'roxma/vim-tmux-clipboard', {
    'vimwiki/vimwiki',
    branch = 'dev',
    init = function()
        vim.g.vimwiki_list = {
            {
                path = '~/vimwiki/',
                index = 'index',
                ext = '.md',
                custom_wiki2html = 'vimwiki_markdown',
                syntax = 'markdown'
            }
        }
        -- vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_filetypes = { 'markdown' }
    end
}, {
    'mattn/emmet-vim',
    ft = { 'html', 'javascript', 'php', 'css', 'vue', 'xml', 'svelte' }
}, {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
    ft = { 'css', 'html', 'svelte', 'js' }
}, 'tpope/vim-surround', 'tpope/vim-repeat', 'ggandor/leap.nvim', {
    'SirVer/ultisnips',
    init = function()
        vim.g.UltiSnipsEditSplit = "vertical"
        vim.g.UltiSnipsExpandTrigger = "<C-e>"
        vim.g.UltiSnipsListSnippets = "<C-l>"
        vim.api.nvim_command(
            'set runtimepath+=~/.local/share/nvim/lazy/vim-snippets')
    end
}, 'honza/vim-snippets', { 'tpope/vim-fugitive', cmd = { "Git" } }, {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
        vim.g.vimtex_compiler_method = 'tectonic'
        vim.opt.conceallevel = 1
        vim.g.tex_conceal = 'abdmgs'
    end
}, {
    'terrortylor/nvim-comment',
    cmd = 'CommentToggle',
    config = function()
        require('nvim_comment').setup({ comment_empty = false })
    end
}, { "SmiteshP/nvim-navic", dependencies = { "neovim/nvim-lspconfig" } }, {
    'hoob3rt/lualine.nvim',
    dependencies = { { 'kyazdani42/nvim-web-devicons', optional = true } },
    config = function()
        require('lualine').setup({ options = { theme = 'dracula' } })
    end
}, {
    'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
        require('bufferline').setup({
            options = {
                diagnostics = 'nvim_lsp',
                separator_style = "slant",
                always_show_bufferline = false,
                hover = { enabled = true, delay = 0, reveal = { 'close' } }
            }
        })
    end
}, {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
        require 'nvim-tree'.setup {
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
}, 'neovim/nvim-lspconfig', {
    'yioneko/nvim-cmp',
    branch = 'perf',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
    },
}, 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua',
    'Frefreak/cmp-nvim-ultisnips', 'onsails/lspkind-nvim', {
    "ray-x/lsp_signature.nvim",
    config = function() require('lsp_signature').setup() end
}, { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-lua/plenary.nvim', {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    init = function()
        vim.treesitter.language.register('markdown', { 'vimwiki.markdown' })
    end
}, { 'mrcjkb/rustaceanvim',          ft = 'rust' },
    { 'kaarmu/typst.vim',                ft = 'typst',       lazy = false }, {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = { "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
            opts = { lsp = { auto_attach = true } }
        }
    }
},
}

return M
