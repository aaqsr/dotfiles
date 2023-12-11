return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    local wk = require("which-key")

    wk.register({
      ["<leader>f"] = {
        name = "+Fuzzy",
        v = { name = "+Vim" },
        l = { name = "+LSP" },
        g = { name = "+Git" }
      }
    })

    -- General
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Search files in directory" })
    vim.keymap.set('n', '<leader>fG', builtin.live_grep, { desc = "Grep files in directory" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Search open files (buffers)" })
    vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "Search currently open file" })

    -- Vim
    vim.keymap.set('n', '<leader>fvh', builtin.help_tags, { desc = "Search help" })
    vim.keymap.set('n', '<leader>fvc', builtin.commands, { desc = "Search commands" })
    vim.keymap.set('n', '<leader>fvC', builtin.colorscheme, { desc = "Search colorschemes" })
    vim.keymap.set('n', '<leader>fvk', builtin.keymaps, { desc = "Search keymaps" })
    vim.keymap.set('n', '<leader>fvo', builtin.vim_options, { desc = "Search options" })

    -- LSP
    vim.keymap.set('n', '<leader>flr', builtin.lsp_references, { desc = "Search references to object" })
    vim.keymap.set('n', '<leader>fld', builtin.lsp_definitions, { desc = "Search definitions of object" })
    vim.keymap.set('n', '<leader>flr', builtin.lsp_implementations, { desc = "Search implementations of object" })

    -- Git
    vim.keymap.set('n', '<leader>fgc', builtin.git_bcommits, { desc = "Search commits of this buffer" })
    vim.keymap.set('n', '<leader>fgf', builtin.git_files, { desc = "Search files in repo" })
    vim.keymap.set('n', '<leader>fgs', builtin.git_status, { desc = "Git status" })

    -- local actions = require('telescope.actions')
    local tele = require('telescope')
    tele.setup {
      prompt_prefix = ' ',
      selection_caret = ' ',
      path_display = { 'smart' },
      defaults = {
        layout_strategy = "vertical",
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
          hijack_netrw = true,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      },
    }
    tele.load_extension("ui-select")
  end
}
