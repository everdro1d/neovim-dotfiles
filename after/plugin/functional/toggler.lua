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

-- ------------------------------------
-- UTILS
-- ------------------------------------

local default_opts = {
    inverses = global_inverses,
    remove_default_inverses = true,
}

require('nvim-toggler').setup(default_opts)

local function update_ft_inverses(ft)
    -- merging with empty tbl does nothing so {} if nil
    local overrides = ft_overrides[ft] or {}

    -- start from empty tbl to avoid mutating default_opts
    require('nvim-toggler').setup(vim.tbl_deep_extend('force',
        {},
        default_opts,
        { inverses = overrides }
    ))
end

local toggler_ft_group = vim.api.nvim_create_augroup("toggler_ft_group", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    group = toggler_ft_group,
    callback = function()
        update_ft_inverses(vim.bo.filetype)
    end,
})
