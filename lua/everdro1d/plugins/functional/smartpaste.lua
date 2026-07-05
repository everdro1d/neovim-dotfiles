return {
    "nemanjamalesija/smart-paste.nvim",
    event = { "VeryLazy", "BufEnter" },
    opts = function()
        vim.keymap.set('n', '<M-p>', function()
            require('smart-paste').paste({ register = '+', key = 'p' })
        end, { desc = '(p)aste from system clipboard' })
        vim.keymap.set('n', '<M-P>', function()
            require('smart-paste').paste({ register = '+', key = 'P' })
        end, { desc = '(P)aste from system clipboard' })
    end,
}
