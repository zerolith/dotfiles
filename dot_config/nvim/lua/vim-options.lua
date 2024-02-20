vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')


vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "WW", ":w!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "BB", ":bw<enter>", {noremap=false})

vim.api.nvim_set_keymap("n", "st", ":TodoTelescope<CR>", {noremap=true})

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


vim.wo.number = true
vim.o.relativenumber = true
vim.o.hlsearch = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.mouse = ''
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.o.conceallevel=2

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_option_value("colorcolumn", "79", {})

 vim.cmd [[
        hi Normal guibg=NONE ctermbg=NONE
    ]]

local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " "
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
