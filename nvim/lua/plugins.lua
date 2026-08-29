
local fn = vim.fn

-- helper function 
local function gh(repo)
    return "https://github.com/" .. repo
end

-- build function for telescope-fzf-native
local function build_fzf_native()
    local plugin_dir = fn.stdpath("data") .. "/site/pack/*/start/telescope-fzf-native.nvim"
    local install_path = fn.glob(plugin_dir, true, true)[1]
    
    if install_path and fn.executable("make") == 1 then
        vim.cmd("cd " .. install_path)
        vim.cmd("!make")
        vim.cmd("cd -")
    end
end

-- register before vim.pack.add() so first-time install emits packchanged immediately
vim.api.nvim_create_autocmd("PackChanged", { callback = build_fzf_native })

-- keep plugins in one native manifest
vim.pack.add({
    -- colorscheme
    gh("morhetz/gruvbox"),
    
    -- icons (single source instead of multiple icon plugins)
    gh("nvim-mini/mini.icons"),
    
    -- telescope dependencies
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    {
        src = gh("nvim-telescope/telescope-fzf-native.nvim"),
        after = "telescope.nvim",
    },
    
    -- file explorer
    gh("nvim-tree/nvim-tree.lua"),
    
    -- lsp (language server protocol)
    gh("neovim/nvim-lspconfig"),
    gh("williamboman/mason.nvim"),
    gh("williamboman/mason-lspconfig.nvim"),
    gh("j-hui/fidget.nvim"),
    
    -- completion (modern alternative to nvim-cmp)
    gh("saghen/blink.lib"),
    gh("saghen/blink.cmp"),
    
    -- snippets
    -- gh("L3MON4D3/LuaSnip"),
    -- gh("rafamadriz/friendly-snippets"),
    
    -- git
    gh("lewis6991/gitsigns.nvim"),
    gh("sindrets/diffview.nvim"),
    
    -- markdown
    gh("iamcco/markdown-preview.nvim"),
    gh("MeanderingProgrammer/render-markdown.nvim"),
    gh("zk-org/zk-nvim"),  -- used to follow [[link]]
    
    -- latex
    gh("lervag/vimtex"),
    
    -- statusline
    gh("nvim-lualine/lualine.nvim"),
   
    -- comments 
    gh("tpope/vim-commentary"),  
    -- surround
    gh("kylechui/nvim-surround"),
    
    -- which-key
    gh("folke/which-key.nvim"),
    
    -- autopairs
    gh("windwp/nvim-autopairs"),
    
    -- notification
    gh("rcarriga/nvim-notify"),
    
    -- utility
    gh("echasnovski/mini.nvim"),
    
})

-- load plugin configurations
require("plugin-configs")
