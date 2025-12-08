return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require('lualine').setup({
      options = {
        theme = vim.g.colors_name,
        -- I don't like the > angle separators
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      }
    })
  end
}
