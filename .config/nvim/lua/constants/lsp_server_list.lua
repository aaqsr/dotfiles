-- Used by 
--  - mason to ensure installed
--  - cmp to set capabilities
--  - vim.lsp.enable() even though mason-lspconfig already calls it because paranoia
--
-- Note: These servers will be installed by mason. 
--       To use a server not available via mason whose config is present in lspconfig,
--       see the plugins/lsp-plugins/lsp.lua  >>  non_mason_servers_list
return {
    "eslint",
    "rust_analyzer",
    "bacon_ls", -- make sure to also install bacon via mason
    "lua_ls",
    "pyright",
    "clangd",
}

