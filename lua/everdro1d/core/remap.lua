-- open explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move highlighted code - try it
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- let the cursor stay put while appending with 'J'
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle when doing half page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in middle when search scrolling
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

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
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace all highlighted" }
)

-- reload source
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("source")
end, { desc = "reload source" })
