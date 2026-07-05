return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-telescope/telescope-project.nvim" },
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.load_extension('project')
        local project_actions = require("telescope._extensions.project.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-t>"] = "move_selection_next",
                        ["<C-n>"] = "move_selection_previous",
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                    },
                    n = {
                        ["t"] = "move_selection_next",
                        ["n"] = "move_selection_previous",
                        ["j"] = "move_selection_next",
                        ["k"] = "move_selection_previous",
                    },
                },
            },
            extensions = {
                project = {
                    base_dirs = {
                        '~/project',
                    },
                    ignore_missing_dirs = true,
                    hidden_files = true,
                    search_by = { "title", "path" },
                    on_project_selected = function(prompt_bufnr)
                        project_actions.change_working_directory(prompt_bufnr, false)
                        vim.cmd("Canola " .. project_actions.get_selected_path(prompt_bufnr))
                    end,
                    mappings = {
                        n = {
                            ['d'] = project_actions.delete_project,
                            ['r'] = project_actions.rename_project,
                            ['c'] = project_actions.add_project,
                            ['C'] = project_actions.add_project_cwd,
                            ['f'] = project_actions.find_project_files,
                            ['s'] = project_actions.search_in_project_files,
                            ['R'] = project_actions.recent_project_files,
                            ['w'] = project_actions.change_working_directory,
                            ['o'] = project_actions.next_cd_scope,
                        },
                        i = {
                            ['<c-d>'] = project_actions.delete_project,
                            ['<c-r>'] = project_actions.rename_project,
                            ['<c-a>'] = project_actions.add_project,
                            ['<c-A>'] = project_actions.add_project_cwd,
                            ['<c-f>'] = project_actions.find_project_files,
                            ['<c-s>'] = project_actions.search_in_project_files,
                            ['<c-R>'] = project_actions.recent_project_files,
                            ['<c-l>'] = project_actions.change_working_directory,
                            ['<c-o>'] = project_actions.next_cd_scope,
                        }
                    }
                },
            },
        })

        -- Keybinds
        vim.keymap.set('n', '<leader>pf', builtin.find_files)
        vim.keymap.set('n', '<C-p>', builtin.git_files)
        vim.keymap.set('n', '<leader>pr', builtin.oldfiles)

        vim.keymap.set('n', '<leader>pws', function()
            builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
        end)
        vim.keymap.set('n', '<leader>pg', function()
            builtin.grep_string({ search = vim.fn.input("grep > ") })
        end)

        vim.keymap.set("n", "<leader>gB", builtin.git_branches, { desc = "open git branch interface" })

        vim.keymap.set('n', '<leader>ps', function()
            telescope.extensions.project.project{ display_type = 'full', hide_workspace = true }
        end)
    end
}
