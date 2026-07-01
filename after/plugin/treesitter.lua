local tsm = require("tree-sitter-manager")

local languages =
{
    -- PACKAGED WITH NVIM (gets overridden either way so include them)
    "c"
    ,"lua"
    ,"markdown"
    ,"vim"
    ,"vimdoc"
    ,"query"
    --

    -- DEVELOPMENT
    ,"java"
    ,"python"
    ,"rust"
    --

    -- SCRIPTS
    ,"bash"
    --

    -- WEB
    ,"html"
    ,"css"
    --

    -- UTILS
    ,"yaml"
    --
}

tsm.setup({
    ensure_installed = languages, -- list of parsers to install at the start of a neovim session
    border = "rounded",
    auto_install = true,
    highlight = true,

    languages = {}, -- override or add new parser sources
})

vim.keymap.set("n", "<leader>ts", function() tsm.open() end, { desc = "tree-sitter manager" })

vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,

    callback = function()
        -- Start Neovim's native treesitter highlighting
        vim.treesitter.start()

        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"

        -- unfolds all folds upon launch
        vim.cmd.normal({ "zR", bang = true })

        -- both of the following limit the creation of folds (bad)
        -- vim.wo.foldlevelstart = 1
        -- vim.wo.foldminlines = 20

        -- Set treesitter-based indentation
        -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
