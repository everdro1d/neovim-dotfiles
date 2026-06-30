-- Helper function to mix an 'fg' hex with the current 'Normal' background hex
function blend_with_bg(fg_hex, alpha)
    -- 1. Get the current background color from the 'Normal' highlight group
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    local bg_int = normal_hl.bg or 0x000000 -- Fallback to black if no bg is found

    -- Extract RGB from the background integer
    local bg_r = bit.rshift(bg_int, 16)
    local bg_g = bit.band(bit.rshift(bg_int, 8), 0xFF)
    local bg_b = bit.band(bg_int, 0xFF)

    -- 2. Extract RGB from the provided target foreground hex string
    local fg_hex_clean = fg_hex:gsub("#", "")
    local fg_r = tonumber(fg_hex_clean:sub(1, 2), 16)
    local fg_g = tonumber(fg_hex_clean:sub(3, 4), 16)
    local fg_b = tonumber(fg_hex_clean:sub(5, 6), 16)

    -- 3. Mix the colors linearly based on alpha (0.0 to 1.0)
    local mix_r = math.floor(fg_r * alpha + bg_r * (1 - alpha))
    local mix_g = math.floor(fg_g * alpha + bg_g * (1 - alpha))
    local mix_b = math.floor(fg_b * alpha + bg_b * (1 - alpha))

    -- Return the new blended color as a hex string
    return string.format("#%02X%02X%02X", mix_r, mix_g, mix_b)
end

local highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
}
local highlight_blended = {
    "BlendedRainbowDelimiterRed",
    "BlendedRainbowDelimiterYellow",
    "BlendedRainbowDelimiterBlue",
    "BlendedRainbowDelimiterOrange",
    "BlendedRainbowDelimiterGreen",
    "BlendedRainbowDelimiterViolet",
    "BlendedRainbowDelimiterCyan",
}
local hooks = require "ibl.hooks"

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    local alpha = 0.75
    local alpha_blended = 0.4
    local current_theme = vim.g.colors_name
    local colors = {}

    if current_theme == "kanagawa" or current_theme == "kanagawa-wave" then
        -- Kanagawa Dark (Wave)
        alpha = 0.75
        alpha_blended = 0.4
        colors = {
            red    = "#C34043", -- autumnRed / waveRed
            yellow = "#DCA561", -- autumnYellow
            blue   = "#7E9CD8", -- crystalBlue
            orange = "#FF9E3B", -- roninYellow / surimiOrange
            green  = "#98BB6C", -- springGreen
            violet = "#957FB8", -- oniViolet
            cyan   = "#7AA89F", -- waveAqua2
        }
    elseif current_theme == "kanagawa-lotus" then
        -- Kanagawa Light (Lotus)
        alpha = 1.0
        alpha_blended = 0.75
        colors = {
            red    = "#c84053", -- lotusRed
            yellow = "#de9800", -- lotusYellow3
            blue   = "#4d699b", -- lotusBlue4
            orange = "#cc6d00", -- lotusOrange
            green  = "#6f894e", -- lotusGreen
            violet = "#624c83", -- lotusViolet4
            cyan   = "#4e8ca2", -- lotusTeal1
        }
    else
        -- Fallback
        colors = {
            red    = "#E06C75",
            yellow = "#E5C07B",
            blue   = "#61AFEF",
            orange = "#D19A66",
            green  = "#98C379",
            violet = "#C678DD",
            cyan   = "#56B6C2",
        }
    end

    -- fairly visible (scope)
    vim.api.nvim_set_hl(0, "RainbowDelimiterRed",    { fg = blend_with_bg(colors.red,    alpha) })
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = blend_with_bg(colors.yellow, alpha) })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue",   { fg = blend_with_bg(colors.blue,   alpha) })
    vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = blend_with_bg(colors.orange, alpha) })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen",  { fg = blend_with_bg(colors.green,  alpha) })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = blend_with_bg(colors.violet, alpha) })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan",   { fg = blend_with_bg(colors.cyan,   alpha) })

    -- more transparent (non-scope)
    vim.api.nvim_set_hl(0, "BlendedRainbowDelimiterRed",    { fg = blend_with_bg(colors.red,    alpha_blended) })
    vim.api.nvim_set_hl(0, "BlendedRainbowDelimiterYellow", { fg = blend_with_bg(colors.yellow, alpha_blended) })
    vim.api.nvim_set_hl(0, "BlendedRainbowDelimiterBlue",   { fg = blend_with_bg(colors.blue,   alpha_blended) })
    vim.api.nvim_set_hl(0, "BlendedRainbowDelimiterOrange", { fg = blend_with_bg(colors.orange, alpha_blended) })
    vim.api.nvim_set_hl(0, "BlendedRainbowDelimiterGreen",  { fg = blend_with_bg(colors.green,  alpha_blended) })
    vim.api.nvim_set_hl(0, "BlendedRainbowDelimiterViolet", { fg = blend_with_bg(colors.violet, alpha_blended) })
    vim.api.nvim_set_hl(0, "BlendedRainbowDelimiterCyan",   { fg = blend_with_bg(colors.cyan,   alpha_blended) })
end)

require("ibl").setup {
    debounce = 50,

    scope = { -- scope indents should be clearly shown
        highlight = highlight,
        char = "▎",
    },

    indent = { -- std indents should be non-intrusive
        highlight = highlight_blended,
        char = "▏",
    },
}
require('rainbow-delimiters.setup').setup {
    strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = highlight,
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
