require("everdro1d.core.modules")
require("everdro1d.core.remap")
require("everdro1d.core.set")

local augroup = vim.api.nvim_create_augroup
local everdro1dGroup = augroup('everdro1d', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

local filetype_indentations = augroup('filetype_indentations', { clear = true })

function R(name)
    require("plenary.reload").reload_module(name)
end

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

autocmd({"BufWritePre"}, {
    group = everdro1dGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('FileType', {
    group = filetype_indentations,
    pattern = { "nix", "css" },
    callback = function ()
        vim.opt_local.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
