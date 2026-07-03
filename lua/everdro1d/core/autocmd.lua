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

-- autocmd({"BufWritePre"}, {
--     group = buffer_cleanup_commands,
--     pattern = "*",
--     callback = function()
--         if vim.bo.fileformat == "unix" then
--             return
--         end
--
--         local choice = vim.fn.confirm("set fileformat to unix?", "&yes\n&no", 2)
--
--         if choice == 1 then
--             vim.cmd("set ff=unix")
--         end
--     end,
-- })

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

local buffer_conv_commands = augroup('buffer_conv_commands', { clear = true })
autocmd("InsertEnter", {
    group = buffer_conv_commands,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = false
    end,
})

autocmd("InsertLeave", {
    group = buffer_conv_commands,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = true
    end,
})

-- open folds in all buffers
autocmd("BufEnter", {
    group = buffer_conv_commands,
    pattern = "*",
    callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("NeogitStatus") then
            return
        end

        -- unfolds all folds upon entering a buffer
        vim.cmd.normal({ "zR", bang = true })
    end,
})
