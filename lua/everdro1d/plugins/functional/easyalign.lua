return {
    "junegunn/vim-easy-align",
    event = { "VeryLazy", "BufEnter" },
    config = function()
        vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
        vim.keymap.set({ 'n', 'x' }, 'gla', '<Plug>(LiveEasyAlign)')
    end
}
