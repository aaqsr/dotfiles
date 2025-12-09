return {
    'neovim/nvim-lspconfig', -- for pre-existing sane defaults

    config = function()
        local lsp_attach = function(args)
            -- set keymaps here

            local opts_with_desc = function(description)
                return { buffer = args.buf, remap = false, desc = description }
            end
            local map_with_desc = function(mode, command, fn, description)
                vim.keymap.set(mode, command, fn, opts_with_desc(description))
            end

            ---@format disable
            map_with_desc("n", "gd",         vim.lsp.buf.definition,    "Jump to definition")
            map_with_desc("n", "K",          vim.lsp.buf.hover,         "Show definition")
            map_with_desc("n", "<leader>lk", vim.lsp.buf.hover,         "Show definition in float (also on K)")
            map_with_desc("n", "<leader>ld", vim.lsp.buf.definition,    "Go to definition (also on gd)")
            map_with_desc("n", "<leader>le", vim.diagnostic.open_float, "Show error details")
            map_with_desc("n", "<leader>lR", vim.lsp.buf.references,    "Open references to object")
            map_with_desc("n", "<leader>lr", vim.lsp.buf.rename,        "Rename symbol")
            map_with_desc("n", "<leader>la", vim.lsp.buf.code_action,   "Show code actions")
            map_with_desc("n", "<leader>lf", vim.lsp.buf.format,        "Format the document")
            ---@format enable

            -- LSP inlay hints
            map_with_desc("n",
                "<leader>li",
                function ()
                    vim.lsp.inlay_hint.enable(
                        not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
                        { bufnr = args.buf }
                    )
                end,
                "Toggle inlay hints"
            )
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
        vim.api.nvim_create_autocmd('LspAttach', { callback = lsp_attach })


        local wk = require("which-key")
        wk.add({
            { "<leader>l", desc = "+LSP" }
        })


        local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        local server_list = require("constants.lsp_server_list")
        vim.lsp.config("*", {
            capabilities = cmp_capabilities
        })
        vim.lsp.enable(server_list)


        -- Configure LSP servers (LSP config is merged into lsp-config's [allegedly])
        --
        -- Configure lua language server for neovim
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- C/C++
        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--clang-tidy",
                "--log=verbose",
                "--background-index",
            },
        })

        -- Rust
        -- bacon-ls
        vim.lsp.config('bacon_ls', {
            init_options = {
                updateOnSave = true,
                updateOnSaveWaitMillis = 1000
            }
        })
        -- bacon-ls does not like rust_analyzer
        vim.lsp.config('rust_analyzer', {
            opts = {
                checkOnSave = false,
                diagnostics = false
            }
        })
    end
}
