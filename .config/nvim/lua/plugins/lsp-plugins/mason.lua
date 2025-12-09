return {
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {
            ensure_installed = require("constants.lsp_server_list")
        },
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
                config = function()
                    require("mason").setup()

                    vim.keymap.set("n", "<leader>ll", vim.cmd.LspInstall, { silent = true, desc = "Install LSP" })
                    vim.keymap.set("n", "<leader>lm", vim.cmd.Mason, { silent = true, desc = "Open Mason (LSP manager)" })
                end
            },
            "neovim/nvim-lspconfig",
        },
    }
}
