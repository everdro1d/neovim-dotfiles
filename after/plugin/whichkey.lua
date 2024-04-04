local wk = require("which-key")

wk.register({
	["<leader>"] = {
		p = {
			name = "+in project",
			f = "find file (tele.)",
			v = "view file system",
			s = "find with grep string",
		},
		a = "add a file to Harpoon",
		u = "show/hide undo tree",
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
})
