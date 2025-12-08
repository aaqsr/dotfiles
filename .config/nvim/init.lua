-----------------------------------------------------------------
--
--          ██╗███╗░░██╗██╗████████╗░░░██╗░░░░░██╗░░░██╗░█████╗░
--          ██║████╗░██║██║╚══██╔══╝░░░██║░░░░░██║░░░██║██╔══██╗
--          ██║██╔██╗██║██║░░░██║░░░░░░██║░░░░░██║░░░██║███████║
--          ██║██║╚████║██║░░░██║░░░░░░██║░░░░░██║░░░██║██╔══██║
--          ██║██║░╚███║██║░░░██║░░░██╗███████╗╚██████╔╝██║░░██║
--          ╚═╝╚═╝░░╚══╝╚═╝░░░╚═╝░░░╚═╝╚══════╝░╚═════╝░╚═╝░░╚═╝
--
-------------------------------------------------------
--                                               ▄▀█ ▄▀█ █▀█ █▀ █▀█
--                                               █▀█ █▀█ ▀▀█ ▄█ █▀▄


------------------
-- SOURCES
------------------
-- My previous vim config
-- Neovim config switcher              || https://www.youtube.com/watch?v=LkHjJlSgKZY
-- Lazy.nvim                           || https://www.youtube.com/watch?v=aqlxqpHs-aQ
-- Config that shows lazy.vim          || https://github.com/dorrajmachai/nvim/
-- Primegen video with his setup       || https://www.youtube.com/watch?v=w7i4amO_zaE&t=1095s
-- Avish's config                      || https://github.com/AvKat/nvim-conf/tree/a29a6b9f99b74b4594bb4e7a4cd45898df09ce11
-------------------------
-- KEYMAPS AND OPTIONS
--------------------------

vim.g.mapleader = ' '       -- set leader
vim.g.maplocalleader = '\\' -- set local leader

-- disable netrw for nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

require("aaqsr.options")
require("aaqsr.keymaps")

--------------------------
-- LAZY SETUP
--------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    ui = {
        border = "single"
    }
}

require("lazy").setup({
    { import = "plugins" },
    { import = "plugins.lsp-plugins" }
}, opts)

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { silent = true, desc = "Open Lazy plugin manager" })

--------------------------
-- Keymap docs
--------------------------
-- Just some keymap documentation that needs to be updated after plugins
local wk = require("which-key")
wk.add({
    { "<leader>w", group = "Window" }
})
