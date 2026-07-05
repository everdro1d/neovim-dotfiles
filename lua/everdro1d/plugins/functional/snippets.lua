-- Contains: neogen, nvim-snippets, nvim-scissors

local snippets_dir = '~/.snippets'

local snippets_path = vim.fn.expand(snippets_dir)
local function setup_snippets()
    if vim.fn.isdirectory(snippets_path) ~= 0 then
        return
    end

    if vim.fn.confirm(string.format("%s not found. Clone everdro1d/snippets?", snippets_dir), "&yes\n&No", 2) == 1 then
        print("Cloning repository...")

        local repo_url = "https://github.com/everdro1d/snippets.git"
        local cmd = string.format("git clone %s %s", repo_url, vim.fn.shellescape(snippets_path))

        local output = vim.fn.system(cmd)

        if vim.v.shell_error == 0 then
            print(string.format("Successfully cloned snippets to %s", snippets_dir))
        else
            print("Error cloning repository: " .. output)
        end
        return
    end

    print("Skipped cloning snippets.")
end

setup_snippets()

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

return {
    {
        "everdro1d/nvim-snippets",
        event = { "VeryLazy", "BufEnter" },
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = function()
            -- setup native snippet completion
            vim.opt.completefunc = "v:lua.nvim_snippets_complete"
            return {
                create_autocmd = true,
                create_cmp_source = false,
                create_native_completion = true,
                native_completion_kind = 'Snippet',

                friendly_snippets = true,

                -- Use package.json file OR name child directories after filetypes
                -- https://www.reddit.com/r/neovim/comments/188js80/comment/kbn9f3b/
                search_paths = {
                    snippets_path
                },

                keys = {},
            }
        end
    },
    -- Functional, UI Focused --
    {
        "chrisgrieser/nvim-scissors",
        event = "VeryLazy",
        dependencies = { "everdro1d/nvim-snippets" },
        opts = function()
            vim.keymap.set( "n", "<leader>se", function()
                require("scissors").editSnippet()
            end, { desc = "Snippet: Edit" })

            -- when used in visual mode, prefills the selection as snippet body
            vim.keymap.set( { "n", "x" }, "<leader>sa", function()
                require("scissors").addNewSnippet()
            end, { desc = "Snippet: Add" })

            return {
                snippetDir = snippets_path,

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
            }
        end
    },
    {
        "danymat/neogen",
        event = { "VeryLazy", "BufEnter" },
        dependencies = { "everdro1d/nvim-snippets" },
        version = "*",
        opts = function ()
            vim.keymap.set("n", "<leader>nf", function()
                require("neogen").generate({ type = "func" })
            end)

            vim.keymap.set("n", "<leader>nt", function()
                require("neogen").generate({ type = "type" })
            end)

            return {
                snippet_engine = "nvim",
                input_after_comment = true,
            }
        end
    },
}
