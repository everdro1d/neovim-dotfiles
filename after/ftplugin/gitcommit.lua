vim.opt_local.spell = true

-- hard cap at 72 with indicator at 73
-- commit titles w/ more than 50 chars can cause trouble when viewing git log
vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = { 50, 73 }

-- disable line numbers
vim.opt_local.nu = false
vim.opt_local.relativenumber = false
-- disable status column
vim.opt_local.statuscolumn = ""
vim.opt_local.signcolumn = "no"

-- erase buf after closing
vim.opt_local.bufhidden = "wipe"

vim.cmd("startinsert")
