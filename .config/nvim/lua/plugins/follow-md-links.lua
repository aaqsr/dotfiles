return {
  -- 'jghauser/follow-md-links.nvim',
  -- dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- config = function()
  -- vim.keymap.set('n', '<bs>', ':edit #<cr>', { silent = true, desc = "Go back in markdown file after following link" })
  -- end
  'Nedra1998/nvim-mdlink',
  config = function()
    require('nvim-mdlink').setup({
      keymap = true,
      cmp = true
    })
  end
}
