return {
    "folke/trouble.nvim",
    event = { "VeryLazy", "BufEnter" },
    opts = function()
        vim.keymap.set("n", "<leader>tt", function()
            require("trouble").toggle("diagnostics")
        end, { desc = "toggle trouble diag. buffer" })

        vim.keymap.set("n", "<leader>tq", function()
            require("trouble").toggle("qflist")
        end, { desc = "toggle trouble quickfix. buffer" })

        vim.keymap.set("n", "<leader>td", function()
            require("trouble").toggle("diagnostics", { filter = { buf = 0 } })
        end, { desc = "toggle local trouble diag. buffer" })
    end
}
