return {
  "lervag/vimtex",
  init = function()
    vim.cmd([[
      filetype plugin indent on
      let g:vimtex_view_general_viewer = 'zathura'
      let g:vimtex_view_zathura_options = '-reuse-instance'
    ]])
  end,
}
