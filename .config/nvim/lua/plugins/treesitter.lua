return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "cpp",
        "css",
        "javascript",
        "typescript",
        "html",
        "rust",
        "scala",
        "racket",
        "bash",
        "python",
        "tsx",
        "css",
        "json",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- Disable slow treesitter highlight for large files
--     disable = function(lang, buf)
--       local max_filesize = 100 * 1024 -- 100 KB
--       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--       if ok and stats and stats.size > max_filesize then
--         return true
--       end
--     end,

      additional_vim_regex_highlighting = false,

    })

    -- foldz
    vim.api.nvim_command("set foldmethod=expr")
    vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
    vim.api.nvim_command("set nofoldenable")
  end
}

