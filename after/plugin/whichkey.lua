local wk = require("which-key")

wk.add({
    { "<leader>es", desc = "view file system" },

    { "<C>p", desc = "find git file (tele.)" },

    { "<leader>a", desc = "add a file to Harpoon" },
    { "<C>e", desc = "open/close Harpoon menu" },
    { "<C>dH", desc = "switch to next buffer in Harpoon" },
    { "<C>dS", desc = "switch to prev. buffer in Harpoon" },
    { "<C>h", desc = "switch to Harpoon 1" },
    { "<C>t", desc = "switch to Harpoon 2" },
    { "<C>n", desc = "switch to Harpoon 3" },
    { "<C>s", desc = "switch to Harpoon 4" },

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


    { "<leader>tt", desc = "toggle trouble buffer" },

    { "<leader>v", group = "buffers" },
    { "<leader>vca", desc = "code actions" },
    { "<leader>vrn", desc = "rename" },
    { "<leader>vrr", desc = "references" },

    { "<leader>u", desc = "show/hide undo tree" },
    { "<tab>", group = "switch focus editor & undo tree" },

    { "K", desc = "show hover docs." },
    { "gd", desc = "go to definition" },
})
