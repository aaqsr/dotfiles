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
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp"
    -- "nvim-treesitter"
  },
  opts = {
    --  completion = {
    --   -- Set to false to disable completion.
    --   nvim_cmp = true,
    --   -- Trigger completion at 2 chars.
    --   min_chars = 2,
    -- },
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
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "telescope.nvim",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
    -- file it will be ignored but you can customize this behavior here.
    ---@param img string
    follow_img_func = function(img)
      if vim.loop.os_uname().sysname == "Darwin" then
        vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
      else
        vim.fn.jobstart({ "xdg-open", url })      -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      end
    end,
  }
}
