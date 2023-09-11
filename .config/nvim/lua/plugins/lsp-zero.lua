return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },             -- Required
    { 'williamboman/mason.nvim' },           -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },     -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' },     -- Required
  },
  config = function()
    local lsp = require('lsp-zero').preset({})

    lsp.preset("recommended")

    lsp.ensure_installed({
      "tsserver",
      "eslint",
      "rust_analyzer",
      "clangd",
      'pyright',
      "lua_ls"
    })

    local wk = require("which-key")

    wk.register({
      ["<leader>"] = {
        l = "+LSP"
      }
    })

    vim.keymap.set("n", "<Space>ll", vim.cmd.LspInstall, { silent = true, desc = "Install LSP" })
    vim.keymap.set("n", "<Space>lm", vim.cmd.Mason, { silent = true, desc = "Open Mason (LSP manager)" })

    lsp.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      -- lsp.default_keymaps({buffer = bufnr})
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<Space>lk", function() vim.lsp.buf.hover() end,
        { buffer = bufnr, remap = false, desc = "Show definition in float (also on K)" })
      vim.keymap.set("n", "<Space>ld", function() vim.lsp.buf.definition() end,
        { buffer = bufnr, remap = false, desc = "Go to definition (also on gd)" })
      vim.keymap.set("n", "<Space>le", function() vim.diagnostic.open_float() end,
        { buffer = bufnr, remap = false, desc = "Show errors" })
      vim.keymap.set("n", "<Space>lr", function() vim.lsp.buf.references() end,
        { buffer = bufnr, remap = false, desc = "Open references to object" })
      vim.keymap.set("n", "<Space>lR", function() vim.lsp.buf.rename() end,
        { buffer = bufnr, remap = false, desc = "Rename symbol" })
      vim.keymap.set("n", "<Space>la", function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, remap = false, desc = "Show code actions" })
      vim.keymap.set("n", "<Space>lf", function() vim.cmd.LspZeroFormat() end,
        { buffer = bufnr, remap = false, desc = "Format the document" })
    end)

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup({
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      }
    })

    lsp.setup()

    -- need to setup `cmp` after lsp-zero
    local cmp = require('cmp')
    -- local cmp_action = require('lsp-zero').cmp_action()
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      mapping = {
        -- `Tab` key to confirm completion
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),

        -- `Enter` key to go scroll list
        ['<CR>'] = cmp.mapping.select_next_item(cmp_select),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
      }
    })
  end
}
