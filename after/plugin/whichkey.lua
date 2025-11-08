local wk = require("which-key")

wk.add({
    { "<C>dH", desc = "switch to next buffer in Harpoon" },
    { "<C>dS", desc = "switch to prev. buffer in Harpoon" },
    { "<C>e", desc = "open/close Harpoon menu" },
    { "<C>h", desc = "switch to Harpoon 1" },
    { "<C>n", desc = "switch to Harpoon 3" },
    { "<C>p", desc = "find git file (tele.)" },
    { "<C>s", desc = "switch to Harpoon 4" },
    { "<C>t", desc = "switch to Harpoon 2" },
    { "<leader>a", desc = "add a file to Harpoon" },
    { "<leader>n", group = "neogen" },
    { "<leader>nf", desc = "function" },
    { "<leader>nt", desc = "type" },
    { "<leader>p", group = "in project" },
    { "<leader>pW", desc = "find with grep WORD (vim.opt)" },
    { "<leader>pWs", desc = "find with grep WORD" },
    { "<leader>pf", desc = "find file (tele.)" },
    { "<leader>ps", desc = "find with grep string" },
    { "<leader>pw", desc = "find with grep word (vim)" },
    { "<leader>pws", desc = "find with grep WORD" },
    { "<leader>es", desc = "view file system" },
    { "<leader>tt", desc = "toggle trouble buffer" },
    { "<leader>u", desc = "show/hide undo tree" },
    { "<leader>v", group = "buffers" },
    { "<leader>vca", desc = "code actions" },
    { "<leader>vrn", desc = "rename" },
    { "<leader>vrr", desc = "references" },
    { "<tab>", group = "switch focus editor & undo tree" },
    { "K", desc = "show hover docs." },
    { "[t", desc = "goto prev. trouble item" },
    { "]t", desc = "goto next trouble item" },
    { "gd", desc = "go to definition" },
})

-- 	["<leader>"] = {
-- 		p = {
-- 			name = "+in project",
-- 			f = "find file (tele.)",
-- 			s = "find with grep string",
--             ["w"] = "find with grep word (vim)",
--             ["W"] = "find with grep WORD (vim.opt)",
--             ws = "find with grep WORD",
--             Ws = "find with grep WORD",
-- 		},
-- 		a = "add a file to Harpoon",
-- 		u = "show/hide undo tree",
--         n = {
--             name = "+neogen",
--             f = "function",
--             t = "type",
--         },
--         tt = "toggle trouble buffer",
--         v = {
--             name = "+buffers",
--             ca = "code actions",
--             rr = "references",
--             rn = "rename",
--         },
--         s = {
-- 			m = "view file system",
--         },
-- 	},
--
-- 	["<tab>"] = { name = "switch focus editor & undo tree" },
--
-- 	["<C>"] = {
-- 		p = "find git file (tele.)",
-- 		e = "open/close Harpoon menu",
-- 		h = "switch to Harpoon 1",
-- 		t = "switch to Harpoon 2",
-- 		n = "switch to Harpoon 3",
-- 		s = "switch to Harpoon 4",
-- 		d = {
-- 			H = "switch to next buffer in Harpoon",
-- 			S = "switch to prev. buffer in Harpoon",
-- 		},
-- 	},
--     -- must be in trouble window to use these
--     ["[t"] = "goto prev. trouble item",
--     ["]t"] = "goto next trouble item",
--
--     K = "show hover docs.",
--     gd = "go to definition",
-- })
