function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
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
local nlspsettings = require('nlspsettings')

nlspsettings.setup({
    config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
    local_settings_dir = ".nlsp-settings",
    local_settings_root_markers = {'.git'},
    append_default_schemas = true,
    loader = 'json'
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    require"lsp_signature".on_attach()

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<space>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                   opts)
    buf_set_keymap('n', '<space>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>',
                   opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>',
                   opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {'pyright', 'tsserver', 'clangd', 'gopls', 'sumneko_lua', 'hls'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150}
    })
end

local rt = require('rust-tools')
rt.setup({
    tools = {
        runnables = {use_telescope = true},
        debuggables = {use_telescope = true},
        inlay_hints = {highlight = "InLayHints", auto = true},
        hover_actions = {auto_focus = true}
    },
    server = {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.keymap.set("n", "<space>a", rt.hover_actions.hover_actions,
                           {buffer = bufnr, silent = true, noremap = true})
        end,
        capabilities = capabilities,
        flags = {debounce_text_changes = 150},
        settings = {}
    }
})

local util = require 'lspconfig/util'
require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    on_attach = on_attach,
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {{formatCommand = "lua-format -i", formatStdin = true}},
            python = {
                {
                    formatCommand = "black --target-version py310 --quiet -",
                    formatStdin = true
                }
            }
        }
    },
    filetypes = {"lua", "python"},
    root_dir = function(fname)
        return util.root_pattern(".git")(fname) or vim.fn.getcwd()
    end
}

vim.cmd('hi InLayHints guifg=#5a5c68')
vim.o.completeopt = 'menu,menuone,noselect'

local cmp = require 'cmp'
cmp.setup({
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
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
        {name = 'nvim_lsp'}, {name = 'ultisnips'}, {name = 'buffer'},
        {name = 'path'}, {name = 'nvim_lua'}
    },
    formatting = {
        fields = {'abbr', 'kind', 'menu'},
        format = function(_, vim_item) return vim_item end
    }

})

-- lspkind
local lspkind = require('lspkind')
cmp.setup {formatting = {format = lspkind.cmp_format()}}

-- treesitter

local ts_config = require('nvim-treesitter.configs')
ts_config.setup {
    highlight = {enable = true, use_languagetree = true},
}

-- telescope
-- Find files using Telescope command-line sugar.
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})

-- leap.nvim
require('leap').set_default_keymaps()
