require('gitsigns').setup {
    signcolumn = true,
    numhl      = false,

    auto_attach = true,

    current_line_blame_opts = {
        delay = 300,
    },

    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local wk = require('which-key')

        wk.add({
            { "<leader>h", group = "git hunk commands" },
        })

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- NAVIGATION --
        -- nav_hunk is async so use callback to center
        local function center() vim.cmd.normal({'zz', bang = true}) end

        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
                center()
            else
                gitsigns.nav_hunk('next', { callback = center })
            end
        end, { desc = "goto next hunk" })

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
                center()
            else
                gitsigns.nav_hunk('prev', { callback = center })
            end
        end, { desc = "goto prev hunk" })

        -- ACTIONS --

        -- HUNK STAGE
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "stage hunk under cursor" })
        map('n', '<leader>hu', gitsigns.stage_hunk, { desc = "unstage hunk under cursor" })
        map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = "stage selected hunk (partial OK)" })
        map('v', '<leader>hu', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = "unstage selected hunk (partial OK)" })

        -- HUNK RESET
        map('n', '<leader>hr', function()
            if vim.fn.confirm("reset this hunk?", "&yes\n&no", 2) == 1 then
                gitsigns.reset_hunk()
            end
        end, { desc = "reset hunk under cursor" })
        map('v', '<leader>hr', function()
            if vim.fn.confirm("reset this hunk?", "&yes\n&no", 2) == 1 then
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end
        end, { desc = "reset the selected hunk (partial OK)" })

        -- BUFFER STAGE
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "stage active buffer" })
        map('n', '<leader>hU', gitsigns.stage_buffer, { desc = "unstage active buffer" })
        -- BUFFER RESET
        map('n', '<leader>hR', function()
            if vim.fn.confirm("reset this hunk?", "&yes\n&no", 2) == 1 then
                gitsigns.reset_buffer()
            end
        end, { desc = "reset active buffer" })

        -- VIEW HUNK DIMENSIONS
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "open hunk preview popup" })
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "show hunk inline diff highlight" })

        -- GIT BLAME POPUP
        map('n', '<leader>hb', function()
            gitsigns.blame_line({ full = true })
        end, { desc = "open hunk git blame popup" })

        -- GIT BLAME VSPLIT
        map('n', '<leader>gb', function()
            local winnr = vim.fn.bufwinnr("gitsigns-blame")
            if winnr > 0 then
                vim.cmd(winnr .. "close")
            else
                gitsigns.blame()
            end
        end, { desc = "open git blame vsplit" })

        -- QUICKFIX
        map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "populate the qf list will all tracked hunks" })
        map('n', '<leader>hq', gitsigns.setqflist, { desc = "populate the qf list with all hunks in the current buffer" })

        -- TEXT OBJECT
        map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = "select hunk" })
    end
}

