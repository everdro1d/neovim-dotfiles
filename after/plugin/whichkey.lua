local wk = require("which-key")

wk.register({
	["<leader>"] = {
		p = {
			name = "+in project",
			f = "find file (tele.)",
			v = "view file system",
			s = "find with grep string",
            ["w"] = "find with grep word (vim)",
            ["W"] = "find with grep WORD (vim.opt)",
            ws = "find with grep WORD",
            Ws = "find with grep WORD",
		},
		a = "add a file to Harpoon",
		u = "show/hide undo tree",
        n = {
            name = "+neogen",
            f = "function",
            t = "type",
        },
        tt = "toggle trouble buffer",
        v = {
            name = "+buffers",
            ca = "code actions",
            rr = "references",
            rn = "rename",
        },
	},

	["<tab>"] = { name = "switch focus editor & undo tree" },

	["<C>"] = {
		p = "find git file (tele.)",
		e = "open/close Harpoon menu",
		h = "switch to Harpoon 1",
		j = "switch to Harpoon 2",
		k = "switch to Harpoon 3",
		l = "switch to Harpoon 4",
		d = {
			H = "switch to next buffer in Harpoon",
			L = "switch to prev. buffer in Harpoon",
		},
	},
    -- must be in trouble window to use these
    ["[t"] = "goto prev. trouble item",
    ["]t"] = "goto next trouble item",

    K = "show hover docs.",
    gd = "go to definition",
})
