local function colors(current_theme)
    local c = "#54546D"

    if current_theme == "wave" or current_theme == "dragon" then
        c = "#54546D" -- sumiInk4
    elseif current_theme == "lotus" then
        c = "#938056" -- boatYellow1
    end

    vim.api.nvim_set_hl(0, "BiscuitColor", { fg = c })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        colors(require("kanagawa")._CURRENT_THEME or "")
    end
})

return {
    "code-biscuits/nvim-biscuits",
    event = "VeryLazy",
    -- depends on vim.treesitter - ensure enabled
    opts = {
        default_config = {
            max_length = 24,
            min_distance = 5,
            prefix_string = "> "
        },

        toggle_keybind = "<leader>vb",
        show_on_start = true,
        cursor_line_only = true,

        language_config = {
            python = {
                disabled = true
            }
        }
    }
}
