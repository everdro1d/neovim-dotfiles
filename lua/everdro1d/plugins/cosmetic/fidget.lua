return {
    "j-hui/fidget.nvim",
    opts = {
        notification = {
            poll_rate = 10,
            filter = vim.log.levels.INFO,
            override_vim_notify = false,

            window = {
                max_width = 0.5,
                align = "top",
                tabstop = 4,
            },
            view = {
                stack_upwards = false,
            },
        },
    }
}
