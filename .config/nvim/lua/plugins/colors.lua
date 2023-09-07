return { 
  -- "ntk148v/habamax.nvim", 
  -- dependencies = { "rktjmp/lush.nvim" },
  -- config = function()
  --   vim.cmd.colorscheme "habamax.nvim"
  -- end
  
  -- "catppuccin/nvim", name = "catppuccin", priority = 1000 
  
  "navarasu/onedark.nvim",

  config = function()
    require('onedark').setup {
      style = 'cool',
      transparent = true,
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
      },
      lualine = {
        transparent = false, -- lualine center bar transparency
      },
    }

    require('onedark').load()
    vim.cmd.colorscheme "onedark"
  end
}

