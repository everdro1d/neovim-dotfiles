local function get_canola_dir()
    if not package.loaded.canola then return "" end

    local dir = require("canola").get_current_dir()
    if dir then
        local relhome = vim.fn.fnamemodify(dir, ":~")
        local root = vim.fs.root(dir, { ".git" })
        if root then
            local relprefix = dir:gsub('\\', '/'):sub(#root + 1):gsub('^/', '')

            local parts = {}
            for match in relprefix:gmatch("([^/]+)") do
                table.insert(parts, match)
            end

            if #parts > 2 then
                local truncpath = string.format(":/%s/.../%s", parts[1], parts[#parts])
                return truncpath
            end

            return string.format(":/%s", relprefix)
        end

        return relhome
    else
        return nil
    end
end

vim.api.nvim_create_autocmd({"BufEnter", "DirChanged"}, {
    callback = function()
        -- get filename; empty check as fnamemodify must return string.
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
        if filename == "" then filename = get_canola_dir() or "[No Name]" end

        -- try get git root, fallback to tmux conf or flake. if still cant, just get cwd.
        local root_dir = vim.fs.root(0, { ".git", ".tmuxinator.yml", "flake.nix" }) or vim.fn.getcwd()
        local project_root = vim.fn.fnamemodify(root_dir, ":t")

        -- if we're in a git dir, try to get the current branch
        -- dont carry forward error messages
        local is_windows = vim.uv.os_uname().sysname:find("Windows") ~= nil
        local dev_null = is_windows and "2>nul" or "2>/dev/null"

        local cmd = string.format("git branch --show-current %s", dev_null)
        local branch_out = vim.fn.systemlist(cmd)

        local branch = ""
        if #branch_out > 0 and branch_out[1] and branch_out[1] ~= "" then
            branch = string.gsub(branch_out[1], "%s+", "")
        end

        local git_str = (branch ~= "") and (":(" .. branch .. ")") or ""

        vim.o.titlestring = string.format("%s - %s%s - %s", "Neovim", project_root, git_str, filename)
        vim.o.title = true
    end,
})
