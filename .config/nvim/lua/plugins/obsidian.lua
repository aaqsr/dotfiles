-- Windows WSL users need wsl-open for the :ObsidianOpen command.
-- MacOS users need pngpaste (brew install pngpaste) for the :ObsidianPasteImg command.
-- Linux users need xclip (X11) or wl-clipboard (Wayland) for the :ObsidianPasteImg command.
--
-- also requires ripgrep

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    -- Optional. All included elsewhere.
    -- nvim-telescope/telescope.nvim
    -- hrsh7th/nvim-cmp
    -- nvim-treesitter
  },
  opts = {
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
    -- see https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file
    mappings = {
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    }
  }
}
