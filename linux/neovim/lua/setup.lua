function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- nvim-comment
map('n', '<A-/>', ':CommentToggle<CR>', {})
map('v', '<A-/>', ':CommentToggle<CR>', {})

-- bufferline
-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map('n', ']b', ':BufferLineCycleNext<CR>', {})
map('n', '[b', ':BufferLineCyclePrev<CR>', {})

-- These commands will move the current buffer backwards or forwards in the bufferline
map('n', '<leader>>', ':BufferLineMoveNext<CR>', {})
map('n', '<leader><', ':BufferLineMovePrev<CR>', {})
map('n', 'gb', ':BufferLinePick<CR>', {})

-- nvim-tree
function open_file_dir()
    local folder = vim.fn.expand('%:p:h')
    vim.fn.chdir(folder)
    vim.api.nvim_command(":NvimTreeOpen")
end

map('n', '<C-n>', ':NvimTreeToggle<CR>', {})
map('n', '<leader>r', ':NvimTreeRefresh<CR>', {})
map('n', '<leader>n', ':NvimTreeFindFile<CR>', {})
map('n', '<leader>o', ':lua open_file_dir()<CR>', {})

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>", opt)

-- lsp
local nvim_lsp = require('lspconfig')

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        if vim.bo.filetype ~= 'rust' then
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        end
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = { 'ruff', 'pyright', 'tsserver', 'clangd', 'gopls', 'lua_ls', 'hls', 'typst_lsp', 'zls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {}
end

local root_files = {
    'pyproject.toml',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
}

require('lspconfig').pyright.setup({
    capabilities = capabilities,
    root_dir = require('lspconfig/util').root_pattern(unpack(root_files)),
    flags = { debounce_text_changes = 150 }
})

require('lspconfig').gdscript.setup({
    filetypes = { "gd", "gdscript", "gdscript3" },
})


-- go.nvim
require('go').setup()
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimport()
    end,
    group = format_sync_grp,
})

local util = require 'lspconfig/util'

require "lspconfig".efm.setup {
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            lua = { { formatCommand = "lua-format -i", formatStdin = true } },
        }
    },
    filetypes = { "lua" },
    root_dir = function(fname)
        return util.root_pattern(".git")(fname) or vim.fn.getcwd()
    end
}

require 'lspconfig'.omnisharp.setup {
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },

    cmd = { "dotnet", "/usr/lib/omnisharp/OmniSharp.dll" },

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = true,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = true,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
}

vim.cmd('hi InLayHints guifg=#5a5c68')
vim.o.completeopt = 'menu,menuone,noselect'

local cmp = require 'cmp'
cmp.setup({
    snippet = { expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'buffer' },
        { name = 'path' }, { name = 'nvim_lua' }
    },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = function(_, vim_item) return vim_item end
    }
})


-- lspkind
local lspkind = require('lspkind')
cmp.setup { formatting = { format = lspkind.cmp_format() } }

-- rustaceanvim
vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*.rs",
    callback = function()
        vim.keymap.set(
            { "n", "v" },
            "<space>ca",
            function()
                vim.cmd.RustLsp('codeAction');
            end,
            { silent = true, buffer = bufnr }
        )
        vim.keymap.set('n', '<leader>rd', function()
                vim.cmd.RustLsp('externalDocs');
            end,
            { silent = true, buffer = bufnr }
        )
    end,
})

-- treesitter

local ts_config = require('nvim-treesitter.configs')
ts_config.setup {
    highlight = { enable = true, use_languagetree = true },
    indent = { enable = true },
}

-- telescope
require('telescope').setup {}
require('telescope').load_extension('fzf')

-- Find files using Telescope command-line sugar.
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})

-- leap.nvim
require('leap').set_default_keymaps()

-- navic
local navic = require('nvim-navic')
navic.setup {
    lsp = {
        auto_attach = true,
    }
}

-- lualine
require("lualine").setup({
    sections = {
        lualine_c = {
            'filename',
            {
                function()
                    return navic.get_location()
                end,
                cond = function()
                    return navic.is_available()
                end
            },
        }
    },
})

-- navbuddy
map('n', '<leader>b', ':Navbuddy<CR>', {})
