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
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
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


    -- Functional --
    {
        "mbbill/undotree",
    },
    {
        "folke/trouble.nvim",
    },
    {
        'andymass/vim-matchup'
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
    },
    {
        "chrisgrieser/nvim-scissors",
        dependencies = { "everdro1d/nvim-snippets" },
    },
    {
        "nguyenvukhang/nvim-toggler",
    },


    -- Navigation --
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
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
