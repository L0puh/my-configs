-- general neovim settings
local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 3 	-- width of tab character 
opt.shiftwidth = 3      -- when pressing >> or << 
opt.softtabstop = 3	-- when pressing tab
opt.expandtab = true	-- converts tabs into spaces
opt.smarttab = true 	-- at start tab uses shiftwidth, else tabstop
opt.autoindent = true 	-- copies indentation from prev line
opt.smartindent = true	-- smart auto-indent for C style 

-- line wrapping
opt.wrap = true
opt.linebreak = true
opt.textwidth = 75

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "no"
opt.mouse = "a"
opt.cursorline = true
opt.showmode = false
opt.laststatus = 2
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.updatetime = 300
opt.timeoutlen = 500

-- split behavior
opt.splitright = true
opt.splitbelow = true

-- misc
opt.wildmenu = true
opt.hidden = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- clipboard
opt.clipboard = "unnamedplus"  -- system clipboard

-- Fold settings
opt.foldmethod = "manual"
opt.foldenable = true
