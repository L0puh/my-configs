-- key mappings

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- better escape
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- save & quit
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-q>", ":q<CR>", opts)
map("n", "<C-S-q>", ":qa<CR>", opts)

-- window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- tab navigation
map("n", "J", ":tabnext<CR>", opts)
map("n", "K", ":tabprevious<CR>", opts)

-- move lines
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- better search
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- formatting
map("n", "Q", "gq", opts)

-- fold toggle
map("n", "<space>", "za", opts)

-- navigate jump list
map("n", "<C-o>", "<C-o>", opts)
map("n", "<C-i>", "<C-i>", opts)

