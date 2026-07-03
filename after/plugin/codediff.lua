require('codediff').setup({

    -- panel configs
    diff = {
        conflict_result_position = "center",
        conflict_result_width_ratio = { 1, 1, 1 },
        jump_to_first_change = true,
        compute_moves = true,
    },
    explorer = {
        width = 30,
        view_mode = "list",
        file_filter = {
            ignore = { ".git/**", ".jj/**" },
        },
        focus_on_select = true,
    },
    history = {
        position = "bottom",
        height = 20,
        view_mode = "list",
    },

    keymaps = {
        view = {
            close_on_open_in_prev_tab = true,
            toggle_layout = "T",

            unstage_hunk = "<leader>hu",

            -- unmap
            stage_hunk   = false,
            discard_hunk = false,
            toggle_compact = false,
        },
    },
})

-- Keybinds
vim.keymap.set("n", "<leader>gdd", function() vim.cmd("CodeDiff") end,              { desc = "open git diff ui (codediff)"  })
vim.keymap.set("n", "<leader>gh", function() vim.cmd("CodeDiff history") end,       { desc = "open git history"             })
vim.keymap.set("v", "<leader>gh", function() vim.cmd("'<,'>CodeDiff history") end,  { desc = "open git history (selection)" })

-- Autocommands
-- hide cursorline
vim.api.nvim_create_autocmd("User", {
    pattern = "CodeDiffOpen",
    callback = function()
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            vim.wo[win].cursorline = false
        end
    end,
})

-- hide tabline
vim.api.nvim_create_autocmd("User", {
    pattern = "CodeDiffOpen",
    callback = function()
        vim.g.codediff_saved_showtabline = vim.o.showtabline
        vim.o.showtabline = 0
    end,
})
-- reset tabline to default
vim.api.nvim_create_autocmd("User", {
    pattern = "CodeDiffClose",
    callback = function()
        if vim.g.codediff_saved_showtabline then
            vim.o.showtabline = vim.g.codediff_saved_showtabline
            vim.g.codediff_saved_showtabline = nil
        end
    end,
})

-- open folds & maintain open in codediff.nvim buffers
vim.api.nvim_create_autocmd("User", {
    pattern = { "CodeDiffOpen", "CodeDiffFileSelect" },
    callback = function()
        -- unfolds all folds upon opening diff view or selecting
        -- a file to diff. Key: it works with the inline toggle
        vim.cmd.normal({ "zR", bang = true })
    end,
})

-- attach gitsigns
vim.api.nvim_create_autocmd("User", {
    pattern = { "CodeDiffOpen", "CodeDiffFileSelect" },
    callback = function(ctx)
        require'gitsigns'.attach({ bufnr = ctx.buf })
    end,
})
