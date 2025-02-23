require("everdro1d.core.remap")
require("everdro1d.core.set")

local augroup = vim.api.nvim_create_augroup
local everdro1dGroup = augroup('everdro1d', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

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

autocmd('LspAttach', {
    group = everdro1dGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- remap mappings for netrw
autocmd('filetype', {
    pattern = "netrw",
    desc = "set mappings for netrw",
    callback = function ()
        local bind = function (lhs, rhs)
            vim.keymap.set("n", lhs, rhs, {remap = true, buffer = true})
        end

        -- dvorak movements
        bind("h", "h")
        bind("t", "j")
        bind("n", "k")
        bind("s", "l")

        -- saner bindings
        bind("u", "-")
    end
})
