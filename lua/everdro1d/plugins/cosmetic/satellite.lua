return {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {
        current_only = true,
        excluded_filetypes = {
            'canola',
            'undotree',
            'NeogitStatus',
            'NeogitDiffView',
            'gitcommit',
            'codediff-explorer',
            'TelescopePrompt',
            'grapple',
            ''
        },
        handlers = {
            gitsigns = {
                enable = true,
                signs = {
                    add = "+",
                    change = "~",
                    delete = "-",
                },
            },

            marks = {
                enable = true,
                key = nil -- disable mgmt
            },
        }
    }
}
