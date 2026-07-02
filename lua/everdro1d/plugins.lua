return {


    -- Cosmetic --
    {
        "rebelot/kanagawa.nvim",
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'brenoprata10/nvim-highlight-colors'
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    {
        "code-biscuits/nvim-biscuits"
        -- depends on tree-sitter - ensure enabled
    },


    -- Functional --
    {
        'andymass/vim-matchup'
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
    },
    {
        "nguyenvukhang/nvim-toggler",
    },
    {
        "junegunn/vim-easy-align",
        init = function()
            vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
            vim.keymap.set({ 'n', 'x' }, 'gla', '<Plug>(EasyAlign)')
        end
    },


    -- Functional, UI Focused --
    {
        "mbbill/undotree",
    },
    {
        "folke/trouble.nvim",
    },
    {
        "chrisgrieser/nvim-scissors",
        dependencies = { "everdro1d/nvim-snippets" },
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "esmuellert/codediff.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
    },
    {
        "esmuellert/codediff.nvim",
        lazy = true,
        cmd = "CodeDiff",
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "BufEnter",
    },


    -- Navigation --
    {
        "cbochs/grapple.nvim",
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-project.nvim",
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },


    -- LSP, Tree-sitter, code-generation, etc. --
    {
        "romus204/tree-sitter-manager.nvim",
    },
    {
        "dundalek/lazy-lsp.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "j-hui/fidget.nvim",
            "everdro1d/nvim-snippets",
        },
        enabled = function()
            -- disable on windows due to nix dependency
            return vim.fn.has("win32") == 0 and vim.fn.has("win64") == 0
        end,
    },
    {
        "everdro1d/nvim-snippets",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
        "danymat/neogen",
        version = "*",
        dependencies = { "everdro1d/nvim-snippets" }
    },
}
