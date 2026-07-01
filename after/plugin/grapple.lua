require('grapple').setup({
    scope = "git_branch",
    icons = false,
    status = true,

    tag_title = function(scope)
        if scope.name == "global" then
            return "Global"
        end

        local s = scope.id
        local _, i = string.find(s, ".*" .. "[%/%\\]")

        return string.sub(s, i+1)
    end,

    win_opts = {
        width = 0.60,
        height = 0.30,

        border = "rounded",
        focusable = true, -- must be true to work in netrw

        title_pos = "left",
        title_padding = "  ",
        footer = "",
    },
})

vim.keymap.set("n", "<leader>a", function() require("grapple").tag() end,                 { desc = "Tag a file"         })
vim.keymap.set("n", "<C-e>",     function() require("grapple").toggle_tags() end,         { desc = "Toggle tags menu"   })

vim.keymap.set("n", "<C-h>",     function() require('grapple').select({ index = 1 }) end, { desc = "Select first tag"   })
vim.keymap.set("n", "<C-t>",     function() require('grapple').select({ index = 2 }) end, { desc = "Select second tag"  })
vim.keymap.set("n", "<C-n>",     function() require('grapple').select({ index = 3 }) end, { desc = "Select third tag"   })
vim.keymap.set("n", "<C-s>",     function() require('grapple').select({ index = 4 }) end, { desc = "Select fourth tag"  })
-- qwerty
vim.keymap.set("n", "<C-j>",     function() require('grapple').select({ index = 2 }) end, { desc = "Select second tag"  })
vim.keymap.set("n", "<C-k>",     function() require('grapple').select({ index = 3 }) end, { desc = "Select third tag"   })
vim.keymap.set("n", "<C-l>",     function() require('grapple').select({ index = 4 }) end, { desc = "Select fourth tag"  })

vim.keymap.set("n", "<C-s-h>",   function() require('grapple').cycle_tags("prev") end,    { desc = "Go to previous tag" })
vim.keymap.set("n", "<C-s-s>",   function() require('grapple').cycle_tags("next") end,    { desc = "Go to next tag"     })
-- qwerty
vim.keymap.set("n", "<C-s-l>",   function() require('grapple').cycle_tags("next") end,    { desc = "Go to next tag"     })
