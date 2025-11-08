vim.g.mapleader = " "
-- open explore
vim.keymap.set("n", "<leader>es", vim.cmd.Ex)

-- save file in normal mode and insert
vim.keymap.set({ "n", "i" }, "<C-s>", vim.cmd.write)

-- remap search movement keys
vim.keymap.set('n', 'm', 'n')
vim.keymap.set('n', 'M', 'N')

-- map movement keys to dvorak
vim.keymap.set({"n","v"}, "h", "h")
vim.keymap.set({"n","v"}, "t", "j")
vim.keymap.set({"n","v"}, "n", "k")
vim.keymap.set({"n","v"}, "s", "l")

-- move highlighted code - try it
vim.keymap.set("v", "T", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "N", ":m '<-2<CR>gv=gv")
-- qwerty
--vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- let the cursor stay put while appending with 'T'
vim.keymap.set("n", "T", "mzJ`z")
-- qwerty
--vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle when doing half page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- preserve clipboard when replacing
vim.keymap.set("x", "<leader>x", [["_dP]],
    { desc = "preserve clipboard replace" })

-- delete to void register (dont copy on delete)
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d",
    { desc = "delete to void reg." })

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]],
    { desc = "yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]],
    { desc = "yank line to system clipboard" })
    -- https://vi.stackexchange.com/a/6135 <- interesting

-- replace all of current word in file
vim.keymap.set(
    "n",
    "<leader>r",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace all current word in file" }
)

-- reload source
vim.keymap.set("n", "<leader><leader>",
    function()
        vim.cmd("source")
    end,
    { desc = "reload source" }
)

vim.keymap.set("n", "<C-F>", "v%=%",
    { desc = "format within scope" }
)

vim.keymap.set("n", "<leader>pwS", "<nop>")
