local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities()
)

vim.o.autocomplete = true
vim.o.autocompletedelay = 0
vim.o.pumheight = 7
vim.o.pumborder = "rounded"

local on_attach = function(e, client, bufnr)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end, { desc = "show a quickfix list based on a search string in the workspace" })
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vih", function()
        local current = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not current, { bufnr = bufnr })
    end, { desc = "toggle inlay hints" })
    vim.keymap.set("n", "<leader>vcl", function()
        local current = vim.lsp.codelens.is_enabled({ bufnr = bufnr })
        vim.lsp.codelens.enable(not current, { bufnr = bufnr })
    end, { desc = "toggle code lens" })

    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    local client_id = type(client) == "number" and client or client.id
    local client_obj = vim.lsp.get_client_by_id(client_id)

    if client_obj and client_obj:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client_id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return {
                    abbr = item.label:gsub("%b()", ""),
                    menu = item.detail or "",
                    info = item.documentation or "",
                }
            end,
            cmp = function(a, b)
                -- Prioritize items starting with underscore lower
                local a_underscore = a.word:match('^_')
                local b_underscore = b.word:match('^_')

                if a_underscore ~= b_underscore then
                    return b_underscore
                end

                -- Safely extract completion_item to prevent nil indexing
                local item_a = vim.tbl_get(a, 'user_data', 'nvim', 'lsp', 'completion_item')
                local item_b = vim.tbl_get(b, 'user_data', 'nvim', 'lsp', 'completion_item')

                -- Fallback comparison if either item is missing the LSP completion item data
                if not item_a or not item_b then
                    return a.word < b.word
                end

                return (item_a.sortText or item_a.label) < (item_b.sortText or item_b.label)
            end
        })
    end

    -- dvorak
    vim.keymap.set("i", "<C-t>", "<C-p>", { desc = "select previous completion" })
    vim.keymap.set("i", "<C-n>", "<C-n>", { desc = "select next completion" })
    -- qwerty
    vim.keymap.set("i", "<C-j>", "<C-p>", { desc = "select previous completion" })
    vim.keymap.set("i", "<C-k>", "<C-n>", { desc = "select next completion" })

    vim.keymap.set("i", "<C-Enter>", "<C-y>", { desc = "accept completion" })
    vim.keymap.set("i", "<C-space>", function()
        vim.lsp.completion.get()
    end, { desc = "trigger autocompletion" })

    -- force select first option
    vim.opt.completeopt = { "menuone", "noinsert", "popup" }
end

require("fidget").setup({})
require("lazy-lsp").setup {
    use_vim_lsp_config = true,

    excluded_servers = {
        "ccls",                            -- prefer clangd
        "denols",                          -- prefer eslint and ts_ls
        "docker_compose_language_service", -- yamlls should be enough?
        "flow",                            -- prefer eslint and ts_ls
        "ltex",                            -- grammar tool using too much CPU
        "quick_lint_js",                   -- prefer eslint and ts_ls
        "scry",                            -- archived on Jun 1, 2023
        "tailwindcss",                     -- associates with too many filetypes
        "biome",                           -- not mature enough to be default
        "oxlint",                          -- prefer eslint
        "nixd",
    },

    preferred_servers = {
        markdown = {},
        python = { "basedpyright", "ruff" },
    },

    -- default config
    vim.lsp.config("*", {
        flags = {
            debounce_text_changes = 150,
        },

        root_markers = { '.git' },

        on_attach = on_attach,

        capabilities = capabilities,
    }),

    -- lua config
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                },

                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },

                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }),
    prefer_local = true, -- Prefer locally installed servers over nix-shell (default: true)
}

vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})
