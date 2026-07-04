-- write into new files with (ext) by default
vim.api.nvim_create_autocmd("User", {
    pattern = "CanolaFileCreated",
    callback = function(args)
        local path = args.data.path
        local ext = vim.fn.fnamemodify(path, ":e")
        local templates = {
            sh = { "#!/usr/bin/env bash", "" },
            py = { "#!/usr/bin/env python3", "" },
        }
        if templates[ext] then
            vim.fn.writefile(templates[ext], path)
        end
    end,
})

-- ncd dir switch command
vim.api.nvim_create_autocmd("VimLeavePre", {
    desc = "change working dir via canola",
    callback = function()
        local cwd = require("canola").get_current_dir()
        local file = io.open(vim.fn.expand("/tmp/nvim_cwd"), "w")
        if file then
            file:write(cwd)
            file:close()
        end
    end
})

-- refresh after :! shell cmds
vim.api.nvim_create_autocmd('ShellCmdPost', {
    callback = function()
        require('canola-git').invalidate()
    end,
})
