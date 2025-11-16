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

-------------------------
-- KEYMAPS AND OPTIONS
--------------------------

vim.g.mapleader = ' ' -- set leader
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
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  ui = {
    border = "single"
  }
}

require("lazy").setup('plugins', opts)

--------------------------
-- Keymap docs
--------------------------
-- Just some keymap documentation that needs to be updated after plugins
local wk = require("which-key")
wk.add({
    { "<leader>w", group = "Window" }
})
