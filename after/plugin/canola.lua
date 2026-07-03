-- refresh after :! shell cmds
vim.api.nvim_create_autocmd('ShellCmdPost', {
    callback = function()
        require('canola-git').invalidate()
    end,
})
