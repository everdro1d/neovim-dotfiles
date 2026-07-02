require('neogit').setup({
    remember_settings = true,

    auto_refresh = true,
    filewatcher = {
        interval = 1000,
        enabled = true,
    },

    process_spinner = false,

    git_services = {
        ["github.com"] = {
            pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
            commit = "https://github.com/${owner}/${repository}/commit/${oid}",
            tree = "https://${host}/${owner}/${repository}/tree/${branch_name}",
        },
        ["gitforge.axolotl-beardie.ts.net"] = {
            pull_request = "https://${host}/${owner}/${repository}/compare/${branch_name}",
            commit = "https://${host}/${owner}/${repository}/commit/${oid}",
            tree = "https://${host}/${owner}/${repository}/src/branch/${branch_name}",
        },
    },

    commit_editor = {
        staged_diff_split_kind = true,
        staged_diff_split_kind = "split_above", -- set a default incase the autocmd fails for some reason
        spell_check = true,
    },

    integrations = {
        telescope = true,
        codediff = true,
    },

    mappings = {
        popup = {
            ["t"] = false,
            ["T"] = "TagPopup",
        },
        status = {
            ["t"] = "MoveDown",
            ["n"] = "MoveUp",
            ["<cr>"] = "Toggle",
            ["e"] = "GoToFile",
            ["-"] = "Stage",
            ["s"] = false,
        },

    },
})

-- Keybinds
vim.keymap.set("n", "<leader>gg",  function() require('neogit').open() end,             { desc = "open neogit ui"         })
vim.keymap.set("n", "<leader>gdp", function() require('neogit').open({ "diff" }) end,   { desc = "open neogit diff panel" })
vim.keymap.set("n", "<leader>gc",  function() require('neogit').open({ "commit" }) end, { desc = "open commit ui"         })

vim.keymap.set("n", "<leader>gp",  function() require('neogit').pull() end,             { desc = "pull from remote"       })
vim.keymap.set("n", "<leader>gP",  function() require('neogit').push() end,             { desc = "push to remote"         })

-- Autocommands
local neogit_staged_diff_split = vim.api.nvim_create_augroup("neogit_staged_diff_split", { clear = true })

vim.api.nvim_create_autocmd({ "VimResized", "WinEnter" }, {
    group = neogit_staged_diff_split,
    callback = function()
        local width = vim.api.nvim_win_get_width(0)

        if width >= 80 then
            require'neogit'.config.values.commit_editor.staged_diff_split_kind = "vsplit_left"
        else
            require'neogit'.config.values.commit_editor.staged_diff_split_kind = "split_above"
        end
    end,
})
