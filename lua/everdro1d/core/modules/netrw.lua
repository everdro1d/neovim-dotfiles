local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local netrw_group = augroup('netrw_group', {})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

-- remap mappings for netrw
autocmd('filetype', {
    group = netrw_group,
    pattern = "netrw",
    desc = "set mappings for netrw",
    callback = function ()
        local bind = function (lhs, rhs, remap)
            vim.keymap.set("n", lhs, rhs, {remap = remap, buffer = true})
        end

        -- dvorak movements
        bind("h", "h",false)
        bind("t", "j",false)
        bind("n", "k",false)
        bind("s", "l",false)

        -- saner bindings
        bind("u", "-",true)
    end
})

autocmd("VimLeavePre", {
    group = netrw_group,
    desc = "change working dir via netrw",
    callback = function()
        vim.cmd('cd %:p:h')
        local cwd = vim.fn.getcwd()
        local file = io.open(vim.fn.expand("/tmp/nvim_cwd"), "w")
        if file then
            file:write(cwd)
            file:close()
        end
    end
})
