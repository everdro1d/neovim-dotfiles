local function get_canola_dir(unnamed, trunc_limit)
    if not package.loaded["canola"] then return 'nil' end

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

            if #parts > trunc_limit then
                local truncpath = string.format(":/%s/%s/.../%s/%s", parts[1], parts[2], parts[3], parts[4], parts[#parts])
                return truncpath
            end

            return string.format(":/%s", relprefix)
        end

        return relhome
    end

    return unnamed
end

local function file_name()
    local M = require('lualine.component'):extend()

    local modules = require('lualine_require').lazy_require {
        utils = 'lualine.utils.utils',
    }

    local default_options = {
        symbols = {
            modified = '[+]',
            readonly = '[-]',
            unnamed = '[No Name]',
            newfile = '[New]',
        },
        file_status = true,
        newfile_status = false,
        trunc_limit = 5,
    }

    local function is_new_file()
        local filename = vim.fn.expand('%')
        return filename ~= ''
        and filename:match('^%a+://') == nil
        and vim.bo.buftype == ''
        and vim.fn.filereadable(filename) == 0
    end

    M.init = function(self, options)
        M.super.init(self, options)
        self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
    end

    M.update_status = function(self)
        local data = vim.fn.expand('%:t')

        if data == '' then
            data = get_canola_dir(self.options.symbols.unnamed, self.options.trunc_limit)
        end

        data = modules.utils.stl_escape(data)

        local symbols = {}
        if self.options.file_status then
            if vim.bo.modified then
                table.insert(symbols, self.options.symbols.modified)
            end
            if vim.bo.modifiable == false or vim.bo.readonly == true then
                table.insert(symbols, self.options.symbols.readonly)
            end
        end

        if self.options.newfile_status and is_new_file() then
            table.insert(symbols, self.options.symbols.newfile)
        end

        return data .. (#symbols > 0 and ' ' .. table.concat(symbols, '') or '')
    end

    return M
end

local last_pattern, last_match_idx, last_interaction_time
local function search_count()
    local M = require('lualine.component'):extend()
    local default_options = {
        maxcount = 999,
        timeout = 500,
        display_timeout = 4000,
    }

    function M:init(options)
        M.super.init(self,options)
        self.options = vim.tbl_extend('keep', self.options or {}, default_options)

    end

    local function update_hl(current, timeout)
        local current_pattern = vim.fn.getreg('/')
        local current_time = vim.loop.hrtime() / 1e6

        if current_pattern ~= last_pattern or (current ~= last_match_idx) then
            last_pattern = current_pattern
            last_match_idx = current
            last_interaction_time = current_time
        end

        if (current_time - last_interaction_time) > timeout then
            return true
        end

        return false
    end

    function M:update_status()
        local ok, result = pcall(vim.fn.searchcount, { maxcount = self.options.maxcount, timeout = self.options.timeout })

        if (not ok or next(result) == nil)
            or (update_hl(result.current, self.options.display_timeout)) then
            return ''
        end

        local denominator = math.min(result.total, result.maxcount)
        if (result.current == 0 and result.total == 0) then
            return '[no]'
        elseif result.current == 0 and result.total ~= 0 then
            return string.format('[n/%d]', denominator)
        end

        return string.format('[%d/%d]', result.current, denominator)
    end

    return M
end

local function macro_status()
    local reg_recording = vim.fn.reg_recording()
    if reg_recording == "" then
        return ""
    else
        return " Recording @" .. reg_recording
    end
end

local function macro_color()
    local hl = vim.api.nvim_get_hl(0, { name = "ModeMsg", link = false })
    local fg = hl.fg and string.format("#%06x", hl.fg) or nil

    return {
        fg = fg,
        gui = hl.bold and "bold" or nil
    }
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        if package.loaded["canola"] and not package.loaded.oil then require("oil") end

        require("lualine").setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = '',
                section_separators = '',
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                        'RecordingEnter',
                        'RecordingLeave',
                    },
                }
            },
            sections = {
                lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
                lualine_b = {'branch', 'diff', { 'diagnostics', icons_enabled = false, symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' }, } },
                lualine_c = { file_name(), { macro_status, color = macro_color() } },
                lualine_x = { search_count(), 'selectioncount', {'fileformat', icons_enabled = false, }, 'encoding', { 'filetype', icons_enabled = false, } },
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end
}
