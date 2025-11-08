local trouble = require("trouble")

trouble.setup({})

vim.keymap.set("n", "<leader>tt", function()
    trouble.toggle("diagnostics")
end, { desc = "toggle trouble diag. buffer" })

vim.keymap.set("n", "<leader>tq", function()
    trouble.toggle("qflist")
end, { desc = "toggle trouble quickfix. buffer" })

vim.keymap.set("n", "<leader>td", function()
    trouble.toggle("diagnostics", { filter = { buf = 0 } })
end, { desc = "toggle local trouble diag. buffer" })
