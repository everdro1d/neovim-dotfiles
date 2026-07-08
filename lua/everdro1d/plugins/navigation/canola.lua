return {
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
    config = function()
        -- write into new files with (ext) by default
        vim.api.nvim_create_autocmd("User", {
            pattern = "CanolaFileCreated",
            callback = function(args)
                local path = args.data.path
                local ext = vim.fn.fnamemodify(path, ":e")
                local templates = {
                    sh = { "#!/usr/bin/env bash", "" },
                    py = { "#!/usr/bin/env python3", "" },
                }
                if templates[ext] then
                    vim.fn.writefile(templates[ext], path)
                end
            end,
        })

        -- ncd dir switch command
        vim.api.nvim_create_autocmd("VimLeavePre", {
            desc = "change working dir via canola",
            callback = function()
                local cwd = require("canola").get_current_dir() or vim.fn.expand('%:p:h')
                local file = io.open(vim.fn.expand("/tmp/nvim_cwd"), "w")
                if file then
                    if cwd then file:write(cwd) end
                    file:close()
                end
            end
        })

        -- refresh after :! shell cmds
        vim.api.nvim_create_autocmd('ShellCmdPost', {
            callback = function()
                require('canola-git').invalidate()
            end,
        })

        -- git file status in sign column
        local gsns = vim.api.nvim_create_namespace('canola_git_signs')
        vim.api.nvim_create_autocmd('User', {
            pattern = 'CanolaReadPost',
            callback = function(args)
                local bufnr = args.data.buf
                local canola = require('canola')
                local cg = require('canola-git')
                local dir = canola.get_current_dir(bufnr)
                if not dir then
                    return
                end
                vim.api.nvim_buf_clear_namespace(bufnr, gsns, 0, -1)
                for lnum = 1, args.data.entry_count do
                    local entry = canola.get_entry_on_line(bufnr, lnum)
                    if entry then
                        local st = cg.get_status(dir, entry.name)
                        if st then
                            vim.api.nvim_buf_set_extmark(bufnr, gsns, lnum - 1, 0, {
                                sign_text = st.char,
                                sign_hl_group = st.hl,
                            })
                        end
                    end
                end
            end,
        })
    end
}
