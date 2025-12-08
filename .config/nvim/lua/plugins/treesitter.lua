-- stolen from https://github.com/AvKat/nvim-conf/blob/9417bf3bbb8a0f17a1b82483ebf0867855470750/lua/plugins/treesitter.lua
-- REQUIRED cargo install --locked tree-sitter-cli or you can use NPM!! :))

-- old treesitter:
-- return {
--     "nvim-treesitter/nvim-treesitter",
--     branch = "master",
--     build = ":TSUpdate",
--     config = function()
--         local configs = require("nvim-treesitter.configs")
--
--         configs.setup({
--             ensure_installed = {
--                 "c",
--                 "cpp",
--                 "lua",
--                 "vim",
--                 "vimdoc",
--                 "query",
--                 "css",
--                 "javascript",
--                 "typescript",
--                 "html",
--                 "rust",
--                 "racket",
--                 "bash",
--                 "python",
--                 "tsx",
--                 "json",
--                 "markdown",
--                 "markdown_inline",
--             },
--             sync_install = false,
--             highlight = { enable = true },
--             indent = { enable = true, disable = { "cpp" } },
--             -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--             auto_install = true,
--
--             -- Disable slow treesitter highlight for large files
--             --     disable = function(lang, buf)
--             --       local max_filesize = 100 * 1024 -- 100 KB
--             --       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--             --       if ok and stats and stats.size > max_filesize then
--             --         return true
--             --       end
--             --     end,
--
--             additional_vim_regex_highlighting = false,
--
--         })
--
--         -- foldz
--         vim.api.nvim_command("set foldmethod=expr")
--         vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
--         vim.api.nvim_command("set nofoldenable")
--     end
-- }


-- new treesitter
local selection_object = function(keys, query_string, query_group, description)
    return {
        keys,
        function()
            require("nvim-treesitter-textobjects.select").select_textobject(query_string, query_group)
        end,
        desc = description,
        mode = { "x", "o" },
    }
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        event = "BufRead",
        branch = "main",
        build = ":TSUpdate",
        ---@class TSConfig
        opts = {
            -- custom handling of parsers
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "vim",
                "vimdoc",
                "css",
                "javascript",
                "typescript",
                "html",
                "rust",
                "bash",
                "python",
                "json",
                "markdown",
                "markdown_inline"
            }
        },
        config = function(_, opts)
            -- install parsers from custom opts.ensure_installed
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                require("nvim-treesitter").install(opts.ensure_installed)
                -- register and start parsers for filetypes
                for _, parser in ipairs(opts.ensure_installed) do
                    local filetypes = parser -- In this case, parser is the filetype/language name
                    vim.treesitter.language.register(parser, filetypes)

                    vim.api.nvim_create_autocmd({ "FileType" }, {
                        pattern = filetypes,
                        callback = function(event)
                            vim.treesitter.start(event.buf, parser)
                        end,
                    })
                end
            end

            -- Auto-install and start parsers for any buffer
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                callback = function(event)
                    local bufnr = event.buf
                    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

                    -- Skip if no filetype
                    if filetype == "" then
                        return
                    end

                    -- Check if this filetype is already handled by explicit opts.ensure_installed config
                    for _, filetypes in pairs(opts.ensure_installed) do
                        local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
                        if vim.tbl_contains(ft_table, filetype) then
                            return -- Already handled above
                        end
                    end

                    -- Get parser name based on filetype
                    local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
                    if not parser_name then
                        return
                    end
                    -- Try to get existing parser (helpful check if filetype was returned above)
                    local parser_configs = require("nvim-treesitter.parsers")
                    if not parser_configs[parser_name] then
                        return -- Parser not available, skip silently
                    end

                    local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

                    if not parser_installed then
                        -- If not installed, install parser synchronously
                        require("nvim-treesitter").install({ parser_name }):wait(30000)
                    end

                    -- let's check again
                    parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

                    if parser_installed then
                        -- Start treesitter for this buffer
                        vim.treesitter.start(bufnr, parser_name)
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        keys = {
            selection_object("af", "@function.outer", "textobjects", "Select outer function"),
            selection_object("if", "@function.inner", "textobjects", "Select inner function"),
            selection_object("ac", "@class.outer", "textobjects", "Select outer class"),
            selection_object("ic", "@class.inner", "textobjects", "Select inner class"),
            selection_object("ao", "@parameter.outer", "textobjects", "Select outer parameter"),
            selection_object("io", "@parameter.inner", "textobjects", "Select inner parameter"),
            selection_object("as", "@local.scope", "locals", "Select local scope"),
        },
        ---@module "nvim-treesitter-textobjects"
        opts = { multiwindow = true },
    }
}
