return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    vim.opt.list = true

    local ibl = require("ibl")
    ibl.setup({
      indent = {
        char = "▏"
      }
    })

    -- ibl.config.indent = {
    --   char = "▏"
    -- }
  end
}
