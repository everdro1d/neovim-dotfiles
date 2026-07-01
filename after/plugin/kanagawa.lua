require('kanagawa').setup({
    transparent = false,         -- do not set background color
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
    overrides = function(colors)
        local theme = colors.theme
        local makeDiagnosticColor = function(color)
            local c = require("kanagawa.lib.color")
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
            NormalFloat = { bg = theme.ui.bg },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },  -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
        }
    end,
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
