local cmp = require('cmp')
vim.opt.completeopt = "menuone,noselect"
cmp.setup {
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
    formatting = {
        format = function(entry, vim_item)
            -- load lspkind icons
            vim_item.kind = string.format("%s %s", require(
                                              "plugins.lspkind_icons").icons[vim_item.kind],
                                          vim_item.kind)
            return vim_item
        end
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },
    sources = {
        {name = 'nvim_lsp'}, {name = 'ultisnips'}, {name = 'buffer'},
        --{name = "nvim_lua"}, {name = "path"}
    }
}
