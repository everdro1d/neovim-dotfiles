local harpoon = require("harpoon")
local harpoon_extensions = require("harpoon.extensions")


-- REQUIRED
harpoon:setup({
    settings = {
        save_on_toggle = true,
    },
})
-- REQUIRED

harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
harpoon:extend(harpoon_extensions.builtins.navigate_with_number())

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

local toggle_opts = {
    border = "rounded",
    title = "File Zoomer - Harpoon",
    title_pos = "left",
    ui_width_ratio = 0.80,
}

vim.keymap.set("n", "<C-e>",
    function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end
)

-- dvorak
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- qwerty
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-H>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-S>", function() harpoon:list():next() end)
-- qwerty
vim.keymap.set("n", "<C-S-L>", function() harpoon:list():next() end)

-- Fix Transparency with Harpoon window
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "harpoon",
    callback = function()
        vim.opt.winblend = 20 -- 0 ~ 100
    end,
})
