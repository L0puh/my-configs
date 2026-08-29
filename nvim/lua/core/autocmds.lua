-- autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- general autocommands
local general_group = augroup("GeneralSettings", { clear = true })

-- resize splits on window resize
autocmd("VimResized", {
    group = general_group,
    pattern = "*",
    command = "tabdo wincmd =",
})

-- return to last edit position
autocmd("BufReadPost", {
    group = general_group,
    pattern = "*",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- highlight on yank
autocmd("TextYankPost", {
    group = general_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- filetype specific settings
local ft_group = augroup("FileTypeSettings", { clear = true })

-- latex template
autocmd("BufNewFile", {
    group = ft_group,
    pattern = "*.tex",
    callback = function()
        if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "" then
            vim.cmd("0r ~/.config/setup/my-configs/template.tex")
        end
    end,
})

-- python settings
autocmd("FileType", {
    group = ft_group,
    pattern = "python",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
})

-- markdown settings
autocmd("FileType", {
    group = ft_group,
    pattern = "markdown",
    callback = function()
        vim.opt_local.conceallevel = 2
    end,
})
