local _onedark = {
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

local _habamax = {
  "ntk148v/habamax.nvim",
  dependencies = { "rktjmp/lush.nvim" },
  config = function()
    vim.cmd("colorscheme habamax.nvim")
  end
}

local _pumpkin = {
  "aaqsr/pumpkin",
  config = function()
    vim.cmd("colorscheme pumpkin")
  end
}

local _catpuccin = {
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

local _sonokai = {
  "sainnhe/sonokai",

  config = function()
    local options = {
      sonokai_style = "shusia",
      sonokai_enable_italic = 1,
      sonokai_transparent_background = 1,
      sonokai_dim_inactive_windows = 1,

    }

    for k, v in pairs(options) do
      vim.g[k] = v
    end

    vim.cmd.colorscheme("sonokai")
  end


}

return _catpuccin
