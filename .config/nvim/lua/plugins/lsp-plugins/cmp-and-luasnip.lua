return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        "hrsh7th/cmp-nvim-lua",
        'hrsh7th/cmp-cmdline',
        'micangl/cmp-vimtex',
        'saadparwaiz1/cmp_luasnip',
        {
            'L3MON4D3/LuaSnip',
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" }
        },

        "p00f/clangd_extensions.nvim", -- for clangd_extensions below
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require("cmp")
        local ls = require("luasnip")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert"
            },

            snippet = {
                expand = function(args)
                    ls.lsp_expand(args.body)
                end,
            },

            sources = cmp.config.sources({
                { name = "nvim_lsp" }, -- lsp
                { name = "luasnip" },  -- snippets
                { name = "buffer" },   -- text within current buffer
                { name = "path" },     -- file system paths
                { name = "vimtex" }
            }),

            mapping = cmp.mapping.preset.insert({
                -- `Tab` key to confirm completion
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    elseif ls.expand_or_locally_jumpable() then
                        ls.expand_or_jump()
                    else
                        -- enable this if you want tab to also try to autocomplete if your cursor after a non-space character
                        -- elseif has_words_before() then
                        --   cmp.complete()
                        fallback()
                    end
                end, { "i", "s" }),
                -- cmp.mapping.,

                -- `Enter` key to go scroll list
                ['<CR>'] = cmp.mapping.select_next_item(cmp_select),

                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),
            }),

            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.recently_used,
                    require("clangd_extensions.cmp_scores"),
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })
    end
}
