vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        "c"
        ,"java"
        ,"python"
        ,"rust"

        ,"bash"
        ,"lua"
        ,"vim"
        ,"vimdoc"

        ,"query"

        ,"html"
        ,"css"
        ,"markdown"
    },

    callback = function()
        -- Start Neovim's native treesitter highlighting
        vim.treesitter.start()

        -- Set treesitter-based indentation
        -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
