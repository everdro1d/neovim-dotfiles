vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.statuscolumn = "%=%l%s"
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"

vim.opt.cmdheight = 0
require("vim._core.ui2").enable({
    msg = {
        targets = 'msg',
        msg = {
          height = 0.5,
          timeout = 4000,
        },
    },
})

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.winborder = "rounded"

