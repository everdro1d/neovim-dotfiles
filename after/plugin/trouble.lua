local trouble = require("trouble")

trouble.setup({})

vim.keymap.set("n", "<leader>tt", function()
    trouble.toggle("diagnostics")
end, { desc = "toggle trouble diag. buffer" })

vim.keymap.set("n", "[t", function()
    trouble.next({skip_groups = true, jump = true}, "diagnostics");
end, { desc = "goto next diag. trouble item" })

vim.keymap.set("n", "]t", function()
    trouble.previous({skip_groups = true, jump = true}, "diagnostics");
end, { desc = "goto prev. diag. trouble item" })
