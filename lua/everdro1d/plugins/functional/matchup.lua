return {
    "andymass/vim-matchup",
    event = { "VeryLazy", "BufEnter" },
    opts = {
        treesitter = {
            enabled = true,
            stopline = 500,
        },

        surround = {
            enabled = 1,
        },

        delim = {
            noskips = 2,
            nomids = 0,
        },

        matchparen = {
            offscreen = {
                method = "", -- rm popup due to extra buffer
            },
        },

        transmute = {
            enabled = 1,
        },
    }
}
