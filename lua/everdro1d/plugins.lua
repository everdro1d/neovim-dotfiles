return {
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "mbbill/undotree",
    },
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
	{
		"mfussenegger/nvim-dap",
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
        "romus204/tree-sitter-manager.nvim",
    },
    {
        "dundalek/lazy-lsp.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "j-hui/fidget.nvim",
        },
		enabled = function()
			-- disable on windows due to nix dependency
			return vim.fn.has("win32") == 0 and vim.fn.has("win64") == 0
		end,
    },
    {
        "danymat/neogen",
        version = "*",
    },
    {
        "folke/trouble.nvim",
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'brenoprata10/nvim-highlight-colors'
    },
    {
        'andymass/vim-matchup'
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
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
}
