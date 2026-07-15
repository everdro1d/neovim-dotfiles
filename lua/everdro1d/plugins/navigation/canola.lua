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
        -- redirect for compat
        package.preload["oil"] = function() return require("canola") end

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

        -- Enable ssh editing
        vim.g.canola_ssh = {
          extra_args = { }, -- scp args
          border = "rounded",
          recursive = true,
          hosts = { }, -- per host override
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

        -- --------------------------------------------------------------------
        -- Stage files from canola
        -- --------------------------------------------------------------------

        -- get `:/` file path from the .git root
        local function get_root_rel_path(root_dir)
            local directory = require('canola').get_current_dir()
            local relpath = string.sub(directory, #root_dir + 1)
            local file_name = require('canola').get_cursor_entry().name

            return string.format(":%s%s", relpath, file_name)
        end

        local function handle_finish(obj, unstage, path)
            if not obj then
                vim.notify("Failed to execute git cmd.", vim.log.levels.ERROR)
                return
            end

            if obj.code ~= 0 then
                local err_msg = obj.stderr and vim.trim(obj.stderr) or "Unknown error"
                vim.notify("Git cmd failed: " .. err_msg, vim.log.levels.ERROR)
                return
            end

            if obj.stdout and vim.trim(obj.stdout) ~= "" then
                print(vim.trim(obj.stdout))
            else
                vim.notify(string.format("%s: %s", (unstage and "Unstaged" or "Staged"), vim.fs.basename(path)), vim.log.levels.INFO)
            end
        end

        -- stage/unstage file under cursor if in a .git root
        local function git_stage(unstage)
            local root_dir = vim.fs.root(0, ".git")
            if not root_dir then return end

            local path = get_root_rel_path(root_dir)

            if unstage then
                vim.system({'git', 'restore', '--staged', '--', path}, { text = true }, vim.schedule_wrap(function(obj)
                    handle_finish(obj, unstage, path)
                end))
            else
                vim.system({'git', 'add', '--', path}, { text = true }, vim.schedule_wrap(function(obj)
                    handle_finish(obj, unstage, path)
                end))
            end

            require('canola-git').invalidate()
        end

        -- register keymaps if the current dir is in a git repo
        vim.api.nvim_create_autocmd('User', {
            pattern = 'CanolaReadPost',
            callback = function(args)
                if not vim.fs.root(0, ".git") then return end

                vim.keymap.set('n', '<leader>hs',
                    function() git_stage(false) end,
                { desc = "stage a git file from canola" })
                vim.keymap.set('n', '<leader>hu',
                    function() git_stage(true) end,
                { desc = "unstage a git file from canola" })
            end,
        })
    end
}
