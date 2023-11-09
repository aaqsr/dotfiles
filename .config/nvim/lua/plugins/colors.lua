-- return {
--   -- "ntk148v/habamax.nvim",
--   -- dependencies = { "rktjmp/lush.nvim" },
--   -- config = function()
--   --   vim.cmd.colorscheme "habamax.nvim"
--   -- end
--
--   -- "catppuccin/nvim", name = "catppuccin", priority = 1000
--
--   "navarasu/onedark.nvim",
--
--   config = function()
--     require('onedark').setup {
--       style = 'cool',
--       transparent = true,
--       code_style = {
--         comments = 'italic',
--         keywords = 'none',
--         functions = 'none',
--         strings = 'none',
--         variables = 'none'
--       },
--       lualine = {
--         transparent = false, -- lualine center bar transparency
--       },
--     }
--
--     require('onedark').load()
--     vim.cmd.colorscheme "onedark"
--   end
-- }
--
-- return {
--   "ntk148v/habamax.nvim", dependencies={ "rktjmp/lush.nvim" },
--   config = function ()
--
--     vim.cmd("colorscheme habamax.nvim")
--   end
-- }

-- return {
--   "aaqsr/pumpkin",
--   config = function ()
--     vim.cmd("colorscheme pumpkin")
--   end
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        mason = true,
        dap = {
          enabled = true,
          enable_ui = true, -- enable nvim-dap-ui
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        which_key = true,
      },
    })

    vim.cmd.colorscheme "catppuccin"
  end
}

