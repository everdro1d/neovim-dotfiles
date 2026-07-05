return {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
        require("nvim-highlight-colors").setup({
            ---'background'|'foreground'|'virtual'
            render = 'background',

            virtual_symbol = '■',

            virtual_symbol_position = 'inline',

            ---'#ffffff'
            enable_hex = true,

            ---'#fff'
            enable_short_hex = true,

            ---'rgb(0 0 0)'
            enable_rgb = true,

            ---'hsl(150deg 30% 40%)'
            enable_hsl = true,

            ---'\033[0;34m'
            enable_ansi = true,

            --'--foreground: 0 69% 69%;'
            enable_hsl_without_function = true,

            ---'var(--testing-color)'
            enable_var_usage = true,

            ---'green'
            enable_named_colors = true,

            ---'bg-blue-500'
            enable_tailwind = false,

            -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
            exclude_filetypes = {},
            exclude_buftypes = {},
            -- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
            exclude_buffer = function(bufnr) end
        })
    end
}
