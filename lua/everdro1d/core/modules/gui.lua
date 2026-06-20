-- This file contains options that are only used for the GUI

-- whether to open in fullscreen by default
local fullscreen = true
vim.fn.rpcnotify(0, 'Gui', 'WindowFullScreen', fullscreen and 1 or 0)

-- fullscreen toggle
vim.keymap.set('n', '<F11>', function()
  fullscreen = not fullscreen
  vim.fn.rpcnotify(0, 'Gui', 'WindowFullScreen', fullscreen and 1 or 0)
end, { silent = true })

-- Display font
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h14"