local wk = require("which-key")

wk.setup({
    preset = "classic",
    win = {
        wo = {
            winblend = 10,
        },
    },
    keys = {
        scroll_down = "<M-d>", -- binding to scroll down inside the popup
        scroll_up = "<M-u>", -- binding to scroll up inside the popup
    },
})

-- set ':W' back to write (too fast will hit this)
vim.cmd("cabbrev W w")

wk.add({
    { "<leader>e",   group = "file system"                                    },
    { "<leader>es",  desc  = "view file system"                               },
    { "<leader>ps",  desc  = "view projects list"                             },

    { "<leader>g",   group = "git commands",              mode = { "n", "x" } },
    { "<leader>gd",  group = "git diff ui",               mode = "n"          },

    { "<leader>i",   desc  = "invert the item under the cursor"               },

    { "ga",          desc  = "EasyAlign (motion/text-object)",     mode = "n" },
    { "ga",          desc  = "EasyAlign selected region",          mode = "x" },
    { "gla",         desc  = "LiveEasyAlign (motion/text-object)", mode = "n" },
    { "gla",         desc  = "LiveEasyAlign selected region",      mode = "x" },

    { "<leader>n",   group = "neogen"                                         },
    { "<leader>nf",  desc  = "function"                                       },
    { "<leader>nt",  desc  = "type"                                           },

    { "<leader>s",   group = "snippets"                                       },

    { "<C-p>",       desc  = "find git file (tele.)"                          },
    { "<leader>p",   group = "in project"                                     },
    { "<leader>pf",  desc  = "find file (tele.)"                              },
    { "<leader>pr",  desc  = "view recently opened files"                     },
    { "<leader>pg",  desc  = "find with grep string"                          },
    { "<leader>pw",  desc  = "find with grep word (only word)"                },
    { "<leader>pws", desc  = "find with grep WORD"                            },
    { "<leader>pW",  desc  = "find with grep WORD (non-interrupting word)"    },
    { "<leader>pWs", desc  = "find with grep WORD"                            },

    { "<leader>t",   group = "trouble & tree-sitter"                          },

    { "<leader>v",   group = "buffers"                                        },
    { "<leader>vca", desc  = "code actions"                                   },
    { "<leader>vrn", desc  = "rename"                                         },
    { "<leader>vrr", desc  = "references"                                     },

    { "<leader>u",   desc  = "show/hide undo tree"                            },
    { "<tab>",       desc  = "switch focus editor & undo tree"                },

    { "K",           desc  = "show hover docs."                               },
    { "gd",          desc  = "go to definition"                               },
    { "Y",           desc  = "Yank to end of line"                            },
    { "&",           desc  = "repeat last substitution"                       },

    { "T",           desc  = "append the next line"                           },
    { "J",           desc  = "append the next line"                           },

    { "gs",          group = "surround"                                       },

    { "<leader>f",   group = "folding"                                        },
    { "<leader>ff",  desc  = "fold selection (manual mode)"                   },
    { "<leader>fa",  desc  = "toggle fold under cursor"                       },
    { "<leader>fA",  desc  = "toggle all folds under cursor"                  },
    { "<leader>fo",  desc  = "open fold under cursor"                         },
    { "<leader>fO",  desc  = "open all folds under cursor"                    },
    { "<leader>fc",  desc  = "close fold under cursor"                        },
    { "<leader>fC",  desc  = "close all folds under cursor"                   },
    { "<leader>fr",  desc  = "open top level folds"                           },
    { "<leader>fR",  desc  = "open all folds in file"                         },
    { "<leader>fm",  desc  = "close top level folds"                          },
    { "<leader>fM",  desc  = "close all folds in file"                        },
    { "<leader>fn",  desc  = "disable active folds"                           },
    { "<leader>fN",  desc  = "enable previously active folds"                 },
    { "<leader>fi",  desc  = "toggle active folds"                            },
    { "<leader>fx",  desc  = "update folds"                                   },
    { "<leader>fd",  desc  = "delete fold under cursor"                       },
    { "<leader>fD",  desc  = "delete all folds under cursor"                  },
    { "<leader>fE",  desc  = "delete all folds in file"                       },

    -- hide normal folding options
    { "za", hidden = true },
    { "zA", hidden = true },
    { "zo", hidden = true },
    { "zO", hidden = true },
    { "zc", hidden = true },
    { "zC", hidden = true },
    { "zr", hidden = true },
    { "zR", hidden = true },
    { "zm", hidden = true },
    { "zM", hidden = true },
    { "zn", hidden = true },
    { "zN", hidden = true },
    { "zi", hidden = true },
    { "zx", hidden = true },
    { "zd", hidden = true },
    { "zD", hidden = true },
    { "zE", hidden = true },
})
