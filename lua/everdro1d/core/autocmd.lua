local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function R(name)
    require("plenary.reload").reload_module(name)
end

local yank_group = augroup('highlight_yank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

local remove_trailing_whitespace = augroup('remove_trailing_whitespace', {})

autocmd({"BufWritePre"}, {
    group = remove_trailing_whitespace,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

local filetype_indentations = augroup('filetype_indentations', { clear = true })

autocmd('FileType', {
    group = filetype_indentations,
    pattern = { "nix", "css" },
    callback = function ()
        vim.opt_local.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
