return {
  "napmn/react-extract.nvim",
  config = function ()
    require("react-extract").setup()

    local wk = require("which-key")
    wk.register({
      ["<leader>l"] = {
        name = "+LSP",
        r = "React"
      }
    }, {
        mode = "v"
      })

    vim.keymap.set({ "v" }, "<Leader>lre", require("react-extract").extract_to_new_file, { desc = "Extract component to new file"})
    vim.keymap.set({ "v" }, "<Leader>lrc", require("react-extract").extract_to_current_file, { desc = "Extract component to same file"})
  end
}
