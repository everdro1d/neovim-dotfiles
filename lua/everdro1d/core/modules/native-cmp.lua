vim.o.autocomplete = true
vim.o.autocompletedelay = 0
vim.o.pumheight = 7
vim.o.pumborder = "rounded"
vim.opt.completeopt = { "menuone", "noinsert", "popup" }

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("autocompletion-sanitizer", { clear = true }),
    callback = function(ev)
        if vim.bo[ev.buf].buftype ~= "" then vim.bo[ev.buf].autocomplete = false end
    end,
})
