local global_inverses = {
    -- default
    ['true'] = 'false',
    ['True'] = 'False',
    ['yes'] = 'no',
    ['on'] = 'off',
    ['left'] = 'right',
    ['up'] = 'down',
    ['enable'] = 'disable',
    ['=='] = '!=',

    -- CUSTOM
    -- misc
    ['"'] = "'", -- " to '
    ['bottom'] = "top",

    -- logical
    ["and"] = "or",
    ["&&"] = "||",
    ["<="] = ">=",
    ["<<"] = ">>",
    ["<"] = ">",
    ["+"] = "-",
}

local ft_overrides = {
    lua = {
        ["=="] = "~=",
        ["else"] = "elseif",
    },

    sh = {
        ["else"] = "elif",
    },
}

local function apply_inverses(bufnr)
    local ft = vim.bo[bufnr].filetype
    -- term, fidget, etc. all have ft but not bt
    if vim.bo[bufnr].buftype ~= "" then
        return
    end

    local overrides = ft_overrides[ft] or {}
    local t = require('nvim-toggler')

    t.reset()
    t.setup({
        remove_default_inverses = true,
        inverses = vim.tbl_extend('force', {}, global_inverses, overrides)
    })
end

return {
    "nguyenvukhang/nvim-toggler",
    event = { "BufWinEnter" },
    config = function()
        local current_buf = vim.api.nvim_get_current_buf()

        local last_ft
        vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
            callback = function(ev)
                local ft = vim.bo[ev.buf].filetype
                if ft ~= last_ft then
                    last_ft = ft
                    apply_inverses(ev.buf)
                end
            end,
        })

        apply_inverses(current_buf)
    end
}
