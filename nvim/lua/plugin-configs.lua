-- plugin-specific configurations

-- ============================================
-- COLORSCHEME
-- ============================================
vim.cmd("colorscheme gruvbox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "Terminal", { bg = "none" })

-- ============================================
-- MINI ICONS
-- ============================================
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

-- ============================================
-- NVIM-TREE (file explorer)
-- ============================================
require("nvim-tree").setup({
   sort_by = "case_sensitive",
   view = {
      width = 30,
      side = "left",
      preserve_window_proportions = false,
   },
   renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "all",
   },
   filters = {
      dotfiles = false,
      exclude = { vim.fn.stdpath("config") .. "/lua" },
   },
   actions = {
      open_file = {
         quit_on_open = false,
         window_picker = {
            enable = false,
         },
      },
   },
   hijack_netrw = false,
   hijack_cursor = false,
   update_cwd = false,
   diagnostics = {
      enable = false,
   },
})

-- keymaps
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

-- ============================================
-- TELESCOPE (fuzzy finder)
-- ============================================
require("telescope").setup({
   defaults = {
      file_ignore_patterns = {
         "node_modules",
         ".git",
         "build",
         "libs",
         "*.so",
         "*.exe",
      },
   },
   pickers = {
      find_files = {
         hidden = false,
      },
   },
})

pcall(require("telescope").load_extension, "fzf")

-- telescope keymaps
vim.keymap.set("n", "<leader>p", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":Telescope help_tags<CR>", { noremap = true, silent = true })

-- ============================================
-- MASON (lsp installer)
-- ============================================
require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = {
      "clangd",  -- c/c++
      "pyright", -- python
      "lua_ls",  -- lua
      --"rust_analyzer", -- rust
      --"gopls",         -- go
   },
   automatic_installation = true,
})


-- ============================================
-- LSP CONFIG
-- ============================================

-- keymaps for lsp
local on_attach = function(client, bufnr)
   local opts = { buffer = bufnr, remap = false }

   -- navigation
   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
   vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
   vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
   vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
   vim.keymap.set("n", "<C-x>", vim.lsp.buf.code_action, opts)

   -- diagnostics
   vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
   vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
   vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

   -- formatting
   vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
   end, opts)
end

-- get blink.cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

-- setup lsp using new vim.lsp.config api (neovim 0.11+)
vim.lsp.config("clangd", {
   cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
   },
   capabilities = capabilities,
   on_attach = on_attach,
   root_markers = { ".clangd", "compile_commands.json", ".git" },
})

vim.lsp.config("pyright", {
   capabilities = capabilities,
   on_attach = on_attach,
   root_markers = { ".git", "pyproject.toml", "setup.py", "requirements.txt" },
   settings = {
      python = {
         analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
         },
      },
   },
})

vim.lsp.config("lua_ls", {
   capabilities = capabilities,
   on_attach = on_attach,
   root_markers = { ".luarc.json", ".git" },
   settings = {
      Lua = {
         runtime = { version = "LuaJIT" },
         diagnostics = { globals = { "vim" } },
         workspace = { library = vim.api.nvim_get_runtime_file("", true) },
         telemetry = { enable = false },
      },
   },
})

-- enable lsp for filetypes
vim.lsp.enable("clangd", "pyright", "lua_ls")

-- fidget (lsp status)
require("fidget").setup()


-- ============================================
-- BLINK.CMP (completion)
-- ============================================

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
   sources = {
      default = { "lsp", "path", "buffer", "snippets" },
   },
   completion = { trigger = { prefetch_on_insert = false } },
   keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
   },
})


-- ============================================
-- LUASNIP (snippets)
-- ============================================

-- local success, luasnip = pcall(require, "luasnip")
-- if success then
--     -- try to load vs code snippets
--     local ok, loader = pcall(require, "luasnip.loaders.from_vscode")
--     if ok then
--         loader.lazy_load()
--     end
--     -- try to load snipmate snippets
--     pcall(require, "luasnip.loaders.from_snipmate").lazy_load()
-- else
--     vim.notify("Luasnip not found - snippets disabled", vim.log.levels.WARN)
-- end

-- ============================================
-- MARKDOWN PREVIEW
-- ============================================
vim.g.mkdp_auto_start = 0
vim.g.mkdp_theme = "dark"
vim.g.mkdp_page_title = "${name}"
vim.g.mkdp_path_to_chrome = "qutebrowser"

vim.api.nvim_create_autocmd("FileType", {
   pattern = "markdown",
   callback = function()
      vim.keymap.set("n", "<leader>o", ":MarkdownPreview<CR>", { buffer = true })
   end,
})

-- ============================================
-- RENDER MARKDOWN
-- ============================================
require("render-markdown").setup({
   file_types = { "markdown", "quarto" },
})

-- ============================================
-- VimTeX (LaTeX)
-- ============================================
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk = {
   out_dir = ".texfiles",
   options = {
      "-shell-escape",
      "-verbose",
      "-file-line-error",
      "-synctex=1",
      "-interaction=nonstopmode",
   },
}

vim.api.nvim_create_autocmd("FileType", {
   pattern = "tex",
   callback = function()
      vim.keymap.set("n", "<leader>t", ":VimtexTocToggle<CR>", { buffer = true })
      vim.keymap.set("n", "<leader>c", ":VimtexClean<CR>", { buffer = true })
      vim.keymap.set("n", "<leader>o", ":VimtexCompile<CR>", { buffer = true })
   end,
})

-- ============================================
-- GITSIGNS
-- ============================================
require("gitsigns").setup({
   signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
   },
   on_attach = function(bufnr)
      local gs = require("gitsigns")
      local opts = { buffer = bufnr }

      vim.keymap.set("n", "]h", gs.next_hunk, opts)
      vim.keymap.set("n", "[h", gs.prev_hunk, opts)
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
      vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
      vim.keymap.set("n", "<leader>hb", function()
         gs.blame_line({ full = true })
      end, opts)
   end,
})

-- ============================================
-- LUALINE (STATUSLINE)
-- ============================================
require("lualine").setup({
   options = {
      theme = "gruvbox",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
   },
   sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
   },
})


-- ============================================
-- VIM-COMMENTARY KEYMAPS
-- ============================================

-- normal mode: comment/uncomment current line
vim.keymap.set("n", "gc", "gcc", { noremap = true, silent = true })

-- visual mode: comment/uncomment selection
vim.keymap.set("v", "gc", "gc", { noremap = true, silent = true })

-- normal mode: comment to end of line
vim.keymap.set("n", "gC", "gcc$", { noremap = true, silent = true })

-- ============================================
-- NVIM-SURROUND
-- ============================================
require("nvim-surround").setup()

-- ============================================
-- WHICH-KEY
-- ============================================
require("which-key").setup()

-- ============================================
-- NVIM-AUTOPAIRS
-- ============================================
require("nvim-autopairs").setup()

-- ============================================
-- NVIM-NOTIFY
-- ============================================

require("notify").setup({
   background_colour = "#121212", -- gruvbox dark0
   -- render style: "compact", "compact", or "minimal"
   render = "default",
   -- timeout settings
   timeout = 3000, -- 3 seconds
   max_height = 20,
   max_width = 80,
   -- position on screen
   position = "top_right", -- "top_right", "top_left", "bottom_right", "bottom_left", "top", "bottom"
   -- animation
   fps = 60,
   level = "info", -- "info", "warn", "error", "debug", "trace"

   -- icons
   icons = {
      ERROR = "x ",
      WARN = "! ",
      INFO = "ℹ ",
      DEBUG = "= ",
      TRACE = "⚡",
   },
   -- stages: "fade_in", "fade_out", "slide", "static"
   stages = "fade",
   -- minimum width
   minimum_width = 40,
})

vim.notify = require("notify")

-- ============================================
-- MINI UTILITIES
-- ============================================
require("mini.ai").setup()
require("mini.surround").setup()
