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
    {
        "nemanjamalesija/smart-paste.nvim",
        event = 'VeryLazy',
        config = function()
            require('smart-paste').setup({})

            vim.keymap.set('n', '<M-p>', function()
                require('smart-paste').paste({ register = '+', key = 'p' })
            end, { desc = '(p)aste from system clipboard' })
            vim.keymap.set('n', '<M-P>', function()
                require('smart-paste').paste({ register = '+', key = 'P' })
            end, { desc = '(P)aste from system clipboard' })
        end,
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
        "barrettruth/canola.nvim",
        branch = "canola",
        dependencies = {{
            "everdro1d/canola-collection",
            branch = "fix-git-status-only-root",
            lazy = false,
        }},
        lazy = false,
        init = function()
            -- Keybinds
            vim.keymap.set('n', '<leader>es', '<CMD>Canola<CR>')

            -- Main config
            local detail = false
            vim.g.canola = {
                columns = {}, -- git_status, icons
                watch = true,

                -- matches '.' but not '..' as existing '..' pairs are usually '../'
                hidden = { enabled = true, patterns = { "^%.[^%.]" }, always = { } },

                confirm = true,

                delete = { wipe = false, recursive = true },
                create = { file_mode = 420, dir_mode = 493 },

                extglob = false,

                keymaps = {
                    ["g?"]    = { callback = "actions.show_help", mode = "n" },
                    ["<CR>"]  = "actions.select",

                    ["<C-s>"] = { callback = "actions.select", opts = { vertical = true } },
                    ["<C-h>"] = { callback = "actions.select", opts = { horizontal = true } },
                    ["<C-t>"] = { callback = "actions.select", opts = { tab = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = { callback = "actions.close", mode = "n" },
                    ["q"]     = { callback = "actions.close", mode = "n" },
                    ["<C-l>"] = "actions.refresh",

                    ["u"]     = { callback = "actions.parent", mode = "n" },
                    ["<C-u>"] = { callback = vim.cmd.undo, mode = "n" },

                    ["_"]     = { callback = "actions.open_cwd", mode = "n" },
                    ["`"]     = { callback = "actions.cd", mode = "n" },
                    ["g~"]    = { callback = "actions.cd", opts = { scope = "tab" }, mode = "n" },

                    ["gs"]    = { callback = "actions.change_sort", mode = "n" },
                    ["gx"]    = "actions.open_external",
                    ["g."]    = { callback = "actions.toggle_hidden", mode = "n" },
                    ["gd"]    = {
                        desc = "Toggle file detail view",
                        callback = function()
                            detail = not detail
                            if detail then
                                require("canola").set_columns({ "permissions", "size", "mtime" })
                            else
                                require("canola").set_columns({})
                            end
                        end,
                    },
                },

                win = {
                    signcolumn = "yes:1",
                },
            }

            -- Git integration
            vim.g.canola_git = {
                show = { untracked = true, ignored = false },
                format = 'compact',
            }
        end,
    },
    -- git
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
