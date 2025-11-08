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

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- remap mappings for netrw
autocmd('filetype', {
    pattern = "netrw",
    desc = "set mappings for netrw",
    callback = function ()
        local bind = function (lhs, rhs)
            vim.keymap.set("n", lhs, rhs, {remap = false, buffer = true})
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
