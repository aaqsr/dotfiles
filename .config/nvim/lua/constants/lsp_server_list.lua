-- Used by 
--  - mason to ensure installed
--  - cmp to set capabilities
--  - vim.lsp.enable() even though mason-lspconfig already calls it because paranoia
return {
    "eslint",
    "rust_analyzer",
    "bacon_ls", -- make sure to also install bacon via mason
    "lua_ls",
    "pyright",
    "clangd",
}

