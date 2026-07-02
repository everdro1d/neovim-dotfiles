local project_actions = require("telescope._extensions.project.actions")

require('telescope').setup {
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
                -- open netrw at root
                vim.cmd("Explore " .. project_actions.get_selected_path(prompt_bufnr))
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
        }
    }
}

require'telescope'.load_extension('project')

local builtin = require('telescope.builtin')

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

vim.keymap.set('n', '<leader>ps', function()
    require'telescope'.extensions.project.project{ display_type = 'full', hide_workspace = true }
end)

vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "open git branch interface" })
