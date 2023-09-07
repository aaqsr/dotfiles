return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 27,
      },
      renderer = {
        group_empty = true,
      },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<BS>', api.tree.change_root_to_parent, opts('Go up dir'))
        vim.keymap.set('n', '<CR>', api.tree.change_root_to_node, opts('Go into dir'))
        -- vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      end
    })
    vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle, { desc = 'Open file explorer tree', silent = true })
  end
}
