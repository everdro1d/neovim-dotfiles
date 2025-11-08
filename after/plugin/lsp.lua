local cmp = require('cmp')
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities()
)
local on_attach = function(client, bufnr)
    -- something
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

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-t>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    },
    {
        { name = 'buffer' },
    })
})

vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
