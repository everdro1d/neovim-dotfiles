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

-- git file status in sign column
local gsns = vim.api.nvim_create_namespace('canola_git_signs')
vim.api.nvim_create_autocmd('User', {
    pattern = 'CanolaReadPost',
    callback = function(args)
        local bufnr = args.data.buf
        local canola = require('canola')
        local cg = require('canola-git')
        local dir = canola.get_current_dir(bufnr)
        if not dir then
            return
        end
        vim.api.nvim_buf_clear_namespace(bufnr, gsns, 0, -1)
        for lnum = 1, args.data.entry_count do
            local entry = canola.get_entry_on_line(bufnr, lnum)
            if entry then
                local st = cg.get_status(dir, entry.name)
                if st then
                    vim.api.nvim_buf_set_extmark(bufnr, gsns, lnum - 1, 0, {
                        sign_text = st.char,
                        sign_hl_group = st.hl,
                    })
                end
            end
        end
    end,
})
