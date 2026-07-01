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

local buffer_cleanup_commands = augroup('buffer_cleanup_commands', { clear = true })

autocmd({"BufWritePre"}, {
    group = buffer_cleanup_commands,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

local filetype_setup_commands = augroup('filetype_setup_commands', { clear = true })

autocmd('FileType', {
    group = filetype_setup_commands,
    pattern = { "nix", "css" },
    callback = function ()
        vim.opt_local.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
