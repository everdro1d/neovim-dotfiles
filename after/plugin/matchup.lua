require('match-up').setup({
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
            method = "popup",
        },
    },

    transmute = {
        enabled = 1,
    },
})
