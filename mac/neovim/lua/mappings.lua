local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

map("n", "<leader>n", ":set nu!<CR>", opt)
map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)
map("n", "<A-/>", ":CommentToggle<CR>", opt)
map("v", "<A-/>", ":CommentToggle<CR>", opt)

-- bufferline tab stuff
map("n", "<S-t>", ":enew<CR>", opt) -- new buffer
map("n", "<C-t>b", ":tabnew<CR>", opt) -- new tab
map("n", "<S-x>", ":bd!<CR>", opt) -- close tab

-- move between tabs
map("n", "<TAB>", ":BufferLineCycleNext<CR>", opt)
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<Space>bp", ":BufferLinePick<CR>", opt)
map("n", "<Space>bpc", ":BufferLinePickClose<CR>", opt)

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>", opt)

-- Vim Fugitive
map("n", "<Leader>gs", ":Git<CR>", opt)
map("n", "<Leader>gh", ":diffget //2<CR>", opt)
map("n", "<Leader>gl", ":diffget //3<CR>", opt)
map("n", "<Leader>gb", ":Git blame<CR>", opt)
