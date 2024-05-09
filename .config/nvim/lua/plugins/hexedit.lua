return {
  "RaafatTurki/hex.nvim",
  config = function()
    local hex = require("hex")
    hex.setup()

    vim.keymap.set('n', '<Leader>lh', hex.toggle,
      { silent = true, desc = "Toggle Binary/Hex Edit View" })
  end
}
