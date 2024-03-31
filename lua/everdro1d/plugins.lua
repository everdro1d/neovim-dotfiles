return {
	"rebelot/kanagawa.nvim",
	"mbbill/undotree",
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ 
		"nvim-telescope/telescope.nvim", 
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {"nvim-treesitter/nvim-treesitter"},
		config = function()
			require("treesitter-context").setup()
		end
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		ft = { 'rust' },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	}
}
