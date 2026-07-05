local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local function spec_sources()
    local pl = "everdro1d.plugins"
    local sources = {
        "cosmetic",
        "functional",
        "git",
        "navigation",
        "syntax",
    }

    local spec = {}

    for _, src in ipairs(sources) do
        table.insert(spec, { import = pl .. "." .. src } )
    end

    return spec
end

require("lazy").setup({
    spec = spec_sources(),
    root = vim.fn.stdpath("data") .. "/state/lazy",
    lockfile = vim.fn.stdpath("config") .. "/state/lazy-lock.json",
})
