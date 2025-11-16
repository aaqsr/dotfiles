-- Requirements:
--
-- Requires ripgrep.
--
-- Also,
--  Windows WSL users need wsl-open for the :ObsidianOpen command.
--  MacOS users need pngpaste (brew install pngpaste) for the :ObsidianPasteImg command.
--  Linux users need xclip (X11) or wl-clipboard (Wayland) for the :ObsidianPasteImg command.
--

return {
    "obsidian-nvim/obsidian.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'hrsh7th/nvim-cmp',
        {
            "folke/snacks.nvim",
            ---@type snacks.Config
            opts = {
                image = {
                    resolve = function(path, src)
                        if require("obsidian.api").path_is_note(path) then
                            return require("obsidian.api").resolve_image_path(src)
                        end
                    end,
                }
            }
        }
    },

    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false,

        workspaces = {
            {
                name = "main",
                path = function()
                    if vim.loop.os_uname().sysname == "Darwin" then
                        return "~/Documents/Obsidian Vault/Main Vault"
                    else
                        return "~/Documents/Obsidian/remote-main"
                    end
                end
            },
        },

        -- Unsure if this works or is even required...
        --
        -- picker = {
        --     -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        --     name = "telescope.nvim",
        --     -- Optional, configure key mappings for the picker. These are the defaults.
        --     -- Not all pickers support all mappings.
        --     note_mappings = {
        --         -- Create a new note from your query.
        --         new = "<C-x>",
        --         -- Insert a link to the selected note.
        --         insert_link = "<C-l>",
        --     },
        --     tag_mappings = {
        --         -- Add tag(s) to current note.
        --         tag_note = "<C-x>",
        --         -- Insert a tag at the current location.
        --         insert_tag = "<C-l>",
        --     },
        -- },

        -- Unsure if this works or is even required...
        --
        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
        -- file it will be ignored but you can customize this behavior here.
        ---@param img string
        -- follow_img_func = function(img)
        --     if vim.loop.os_uname().sysname == "Darwin" then
        --         vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
        --     else
        --         vim.fn.jobstart({ "xdg-open", url })      -- linux
        --         -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        --     end
        -- end,
    },
}
