return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require("nvim-navic")
    require('lualine').setup({
      options = {
        theme = "catppuccin",
        -- I don't like the > angle separators
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      -- breadcrumbs in winbar
      winbar = {
        lualine_c = {
          {
            "navic",
            color_correction = "dynamic",
            navic_opts = {
              highlight = true,
              click = true,
              separator = " > ",
              icons = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Class = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = ' ',
                Interface = ' ',
                Function = ' ',
                Variable = ' ',
                Constant = ' ',
                String = ' ',
                Number = ' ',
                Boolean = ' ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = ' ',
                EnumMember = ' ',
                Struct = ' ',
                Event = ' ',
                Operator = ' ',
                TypeParameter = ' '
              }
            }
          }
        }
      }
    })
  end
}
