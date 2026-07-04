local snippets_dir = vim.fn.expand('~') .. '/snippets'

-- Snippet Engine
require('snippets').setup({
    create_autocmd = true,
    create_cmp_source = false,
    create_native_completion = true,
    native_completion_kind = 'Snippet',

    friendly_snippets = true,

    -- Use package.json file OR name child directories after filetypes
    -- https://www.reddit.com/r/neovim/comments/188js80/comment/kbn9f3b/
    search_paths = {
        snippets_dir
    },

    keys = {},
})

-- setup native snippet completion
vim.opt.completefunc = "v:lua.nvim_snippets_complete"

-- Snippet Manager
require("scissors").setup({
    snippetDir = snippets_dir,

    snippetSelection = {
		picker = "auto", ---@type "auto"|"fzf-lua"|"telescope"|"snacks"|"vim.ui.select"
		telescope = {
			-- By default, the query only searches snippet prefixes. Set this to
			-- `true` to also search the body of the snippets.
			alsoSearchSnippetBody = true,

			-- accepts the common telescope picker config
			opts = {
				layout_strategy = "vertical",
				layout_config = {
                    mirror = true,
					width = 0.6,
					preview_height = 0.6,
				},
			},
		},
	},

	jsonFormatOpts = { -- formatting of snippet files, passed to `:h vim.json.encode()`
		sort_keys = true,
		indent = "    ",
	},
})

-- Keybinds
-- Keybind functions
local next_or_expand = function()
    if vim.snippet.active({ direction = 1 }) then
        vim.schedule(function()
            vim.snippet.jump(1)
        end)
    end

    -- Open completion to expand
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-u>", true, true, true), "i", false)
end

local previous = function()
    if vim.snippet.active({ direction = -1 }) then
        vim.schedule(function()
            vim.snippet.jump(-1)
        end)
    end
end

-- dvorak
vim.keymap.set({ "i", "s" }, "<C-s>", next_or_expand, { silent = true, desc = "jump to next snippet part or open completion" })
vim.keymap.set({ "i", "s" }, "<C-h>", previous,       { silent = true, desc = "go back a snippet part" })
-- qwerty
vim.keymap.set({ "i", "s" }, "<C-l>", next_or_expand, { silent = true, desc = "jump to next snippet part or open completion" })

vim.keymap.set( "n", "<leader>se", function()
    require("scissors").editSnippet()
end, { desc = "Snippet: Edit" })

 -- when used in visual mode, prefills the selection as snippet body
vim.keymap.set( { "n", "x" }, "<leader>sa", function()
    require("scissors").addNewSnippet()
end, { desc = "Snippet: Add" })

