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
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- let the cursor stay put while appending with 'T'
vim.keymap.set("n", "T", "mzJ`z")
-- qwerty
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle when doing half page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- preserve clipboard when replacing and deleting
vim.keymap.set("x", "<leader>x", [["_dP]],
    { desc = "preserve clip. replace (void reg.)" })
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]],
    { desc = "preserve clip. delete (void reg.)" })

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]],
    { desc = "yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]],
    { desc = "yank line to system clipboard" })

-- system clipboard normal functions (<C-c> & <C-p>)
vim.keymap.set({"v"}, "<C-c>", [["+y]],
    { desc = "yank to system clipboard" })
vim.keymap.set({"i", "c"}, "<C-v>", [[<C-r>+]],
    { desc = "paste from system clipboard" })

-- replace all of current word in file
vim.keymap.set(
    "n",
    "<leader>r",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace all current word in file" }
)

vim.keymap.set("n", "<leader><leader>",
    function()
        local ft = vim.bo.filetype
        if ft == "vim" or ft == "lua" then
            vim.cmd("source")
            print("Sourced " .. vim.fn.expand("%"))
        else
            print("Not a Vim/Lua file; Nothing sourced")
        end
    end,
    { desc = "reload current nvim config file" }
)

vim.keymap.set("n", "<C-F>", "v%=%",
    { desc = "format within scope" }
)

-- Folding map - rebind for use in which-key organization help

vim.keymap.set("n", "<leader>ff", "zf")
vim.keymap.set("n", "<leader>fa", "za")
vim.keymap.set("n", "<leader>fA", "zA")
vim.keymap.set("n", "<leader>fo", "zo")
vim.keymap.set("n", "<leader>fO", "zO")
vim.keymap.set("n", "<leader>fc", "zc")
vim.keymap.set("n", "<leader>fC", "zC")
vim.keymap.set("n", "<leader>fr", "zr")
vim.keymap.set("n", "<leader>fR", "zR")
vim.keymap.set("n", "<leader>fm", "zm")
vim.keymap.set("n", "<leader>fM", "zM")
vim.keymap.set("n", "<leader>fn", "zn")
vim.keymap.set("n", "<leader>fN", "zN")
vim.keymap.set("n", "<leader>fi", "zi")
vim.keymap.set("n", "<leader>fx", "zx")
