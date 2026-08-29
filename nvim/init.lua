
vim.opt.packpath = vim.fn.stdpath("data") .. "/site"

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- core settings
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- plugins
require("plugins")

