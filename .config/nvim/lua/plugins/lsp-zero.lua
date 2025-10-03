return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- Breadcrumbs and go to code section support
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        { "SmiteshP/nvim-navic", opts = { lsp = { auto_attach = true } } },
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    },
    -- LSP Support
    { 'neovim/nvim-lspconfig' },             -- Required
    { 'williamboman/mason.nvim' },           -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },     -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    {
      'L3MON4D3/LuaSnip',
      dependencies = { "rafamadriz/friendly-snippets" },
    }, -- Required


    -- clangd extra
    "p00f/clangd_extensions.nvim",
  },
  config = function()
    -- set up breadcrumbs real quick (also see lua-line for more)
    vim.keymap.set("n", "<leader>N", vim.cmd.Navbuddy, { silent = true, desc = "Open Code Navigation Menu" })

    local lsp = require('lsp-zero').preset({})

    lsp.preset("recommended")

    lsp.ensure_installed({
      "eslint",
      "rust_analyzer",
      "clangd",
      'pyright',
      "lua_ls",
    })

    local wk = require("which-key")

    wk.register({
      ["<leader>"] = {
        l = "+LSP"
      }
    })

    vim.keymap.set("n", "<leader>ll", vim.cmd.LspInstall, { silent = true, desc = "Install LSP" })
    vim.keymap.set("n", "<leader>lm", vim.cmd.Mason, { silent = true, desc = "Open Mason (LSP manager)" })

    lsp.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      -- lsp.default_keymaps({buffer = bufnr})
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>lk", function() vim.lsp.buf.hover() end,
        { buffer = bufnr, remap = false, desc = "Show definition in float (also on K)" })
      vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end,
        { buffer = bufnr, remap = false, desc = "Go to definition (also on gd)" })
      vim.keymap.set("n", "<leader>le", function() vim.diagnostic.open_float() end,
        { buffer = bufnr, remap = false, desc = "Show error details" })
      vim.keymap.set("n", "<leader>lE", function() require('telescope.builtin').diagnostics({ severity_bound = 0 }) end,
          buffer = bufnr, remap = false, desc = "Show all errors" })
      vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.references() end,
        { buffer = bufnr, remap = false, desc = "Open references to object" })
      vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end,
        { buffer = bufnr, remap = false, desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, remap = false, desc = "Show code actions" })
      vim.keymap.set("n", "<leader>lf", function() vim.cmd.LspZeroFormat() end,
        { buffer = bufnr, remap = false, desc = "Format the document" })
    end)

    -- whilst I am here, I might as well also set up format on save,
    -- vim.cmd(
    -- [[autocmd BufWritePre * silent lua
    -- function() if vim.fn.exists(':IndentLinesToggle') > 0 then vim.cmd.LspZeroFormat() end ]])

    -- Configure lua language server for neovim
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

    -- require('lean').setup {
    --   lsp = { on_attach = (function(_, bufnr)
    --     local function cmd(mode, lhs, rhs)
    --       vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = true })
    --     end
    --     local opts = { buffer = bufnr, remap = false }
    --
    --     -- Autocomplete using the Lean language server
    --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    --
    --     -- Support for triggering code actions (e.g. "Try this:" suggestions from `simp?`)
    --     cmd('n', '<leader>a', vim.lsp.buf.code_action)
    --     cmd('i', '<C-a>', vim.lsp.buf.code_action)
    --
    --     -- <leader>n will jump to the next Lean line with a diagnostic message on it
    --     -- <leader>N will jump backwards
    --     -- cmd('n', '<leader>n', function() vim.diagnostic.goto_next { popup_opts = { show_header = false } } end)
    --     -- cmd('n', '<leader>N', function() vim.diagnostic.goto_prev { popup_opts = { show_header = false } } end)
    --
    --     -- <leader>K will show all diagnostics for the current line in a popup window
    --     cmd('n', '<leader>K',
    --       function() vim.diagnostic.open_float(0, { scope = "line", header = false, focus = false }) end)
    --
    --     -- <leader>q will load all errors in the current lean file into the location list
    --     -- (and then will open the location list)
    --     -- see :h location-list if you don't generally use it in other vim contexts
    --     cmd('n', '<leader>q', vim.diagnostic.setloclist)
    --
    --     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    --     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    --     vim.keymap.set("n", "<leader>lk", function() vim.lsp.buf.hover() end,
    --       { buffer = bufnr, remap = false, desc = "Show definition in float (also on K)" })
    --     vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end,
    --       { buffer = bufnr, remap = false, desc = "Go to definition (also on gd)" })
    --     vim.keymap.set("n", "<leader>le", function() vim.diagnostic.open_float() end,
    --       { buffer = bufnr, remap = false, desc = "Show errors" })
    --     vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.references() end,
    --       { buffer = bufnr, remap = false, desc = "Open references to object" })
    --     vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end,
    --       { buffer = bufnr, remap = false, desc = "Rename symbol" })
    --     vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end,
    --       { buffer = bufnr, remap = false, desc = "Show code actions" })
    --     vim.keymap.set("n", "<leader>lf", function() vim.cmd.LspZeroFormat() end,
    --       { buffer = bufnr, remap = false, desc = "Format the document" })
    --   end) },
    --   mappings = true,
    -- }

    -- Make sure you are in a git repo!!
    require('lspconfig').verible.setup {
      cmd = { 'verible-verilog-ls', '--rules_config_search' },
      filetypes = { 'systemverilog', 'verilog' },
      root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
      end,
    }
    require('lspconfig').svlangserver.setup {
      on_init = function(client)
        local path = client.workspace_folders[1].name

        -- if path == '/path/to/project1' then
        --   client.config.settings.systemverilog = {
        --     includeIndexing     = { "**/*.{sv,svh}" },
        --     excludeIndexing     = { "test/**/*.sv*" },
        --     defines             = {},
        --     launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
        --     formatCommand       = "/tools/verible-verilog-format"
        --   }
        -- elseif path == '/path/to/project2' then
          client.config.settings.systemverilog = {
            includeIndexing     = { "**/*.{sv,svh}" },
            excludeIndexing     = { "sim/**/*.sv*" },
            defines             = {},
            launchConfiguration = "/tools/verilator -sv -Wall --lint-only --timing",
            formatCommand       = "/tools/verible-verilog-format"
          }
        -- end

        client.notify("workspace/didChangeConfiguration")
        return true
      end
    }

    lsp.setup()

    -- helper used below
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- need to setup `cmp` after lsp-zero
    local cmp = require('cmp')
    local ls = require("luasnip")
    -- local cmp_action = require('lsp-zero').cmp_action()
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      mapping = {
        -- `Tab` key to confirm completion
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif ls.expand_or_locally_jumpable() then
            ls.expand_or_jump()
          else
            -- enable this if you want tab to also try to autocomplete if your cursor after a non-space character
            -- elseif has_words_before() then
            --   cmp.complete()
            fallback()
          end
        end, { "i", "s" }),
        -- cmp.mapping.,

        -- `Enter` key to go scroll list
        ['<CR>'] = cmp.mapping.select_next_item(cmp_select),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
      },

      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.recently_used,
          require("clangd_extensions.cmp_scores"),
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })

    -- set up friendly snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    -- vim.keymap.set({ "i" }, "<Tab>", function() ls.jump(1) end,
    --   { silent = true, desc = "Jump forward when autocompleteing snippet" })
  end
}
