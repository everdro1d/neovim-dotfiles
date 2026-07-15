local function get_canola_dir(canola)
    if not canola then return 'nil' end

    local dir = canola.get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        return nil
    end
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

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
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
                    },
                }
            },
            sections = {
                lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
                lualine_b = {'branch', 'diff', { 'diagnostics', icons_enabled = false, symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' }, } },
                lualine_c = {{'filename', symbols = { unnamed = get_canola_dir(require('canola')) or '[No Name]' } } },
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
