return {
  'scalameta/nvim-metals',
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.opt_global.shortmess:remove("F")

    local metals_config = require("metals").bare_config()
    metals_config.init_options.statusBarProvider = "on"

    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }

    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function(client, bufnr)
      -- on_attach(client, bufnr)
      -- require("metals").setup_dap()
    end


    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)

        vim.keymap.set("n", "<leader>ls", function()
          require("telescope").extensions.metals.commands()
        end, { desc = "Open Scala Metals Cmd Palette" })
      end,
      group = nvim_metals_group,
    })
  end
}
