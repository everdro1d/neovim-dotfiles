vim.o.complete = ".,w,b,o"
vim.o.autocomplete = true
vim.o.autocompletedelay = 0
vim.o.pumheight = 7
vim.o.pumborder = "rounded"
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "popup" }

vim.api.nvim_create_autocmd("BufNew", {
    group = vim.api.nvim_create_augroup("autocompletion-sanitizer", { clear = true }),
    callback = function(ev)
        if vim.bo[ev.buf].buftype ~= "" then vim.bo[ev.buf].autocomplete = false end
    end,
})

-- Completion Keybinds
-- dvorak
vim.keymap.set("i", "<C-n>", "<C-p>", { desc = "select previous completion" })
vim.keymap.set("i", "<C-t>", "<C-n>", { desc = "select next completion" })
-- qwerty
vim.keymap.set("i", "<C-k>", "<C-p>", { desc = "select previous completion" })
vim.keymap.set("i", "<C-j>", "<C-n>", { desc = "select next completion" })

vim.keymap.set("i", "<C-Enter>", "<C-y>", { desc = "accept completion" })

vim.keymap.set("i", "<C-space>", "<C-X><C-O>", { desc = "trigger autocompletion (local|lsp)" })
vim.keymap.set("i", "<C-F>", "<C-X><C-F>", { desc = "file path autocompletion" })
