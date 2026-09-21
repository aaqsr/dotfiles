return {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup({
      toggler = {
        line = "<leader>/",
      },
      opleader = {
        line = "<leader>/"
      }
    })

    local ft = require('Comment.ft')

    -- comment string for SML
    ft.set('sml', {'(* %s *)', '(* %s *)'})
  end
}
