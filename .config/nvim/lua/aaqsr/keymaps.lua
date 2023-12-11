--------------------------
-- KEYMAPS
--------------------------

local opts = { silent = true } -- i don't want to have to write these after every keymap
local function opts_with_desc(desc)
  return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end
local term_opts = { silent = true } -- same for the terminal keybindings


vim.keymap.set('n', '<Space>', '', opts) -- I don't remember why this is useful but I'm not deleting it
vim.keymap.set('n', '<leader>w', ':w<CR>', opts_with_desc("Save file"))

-- Movement keys respect line wraps
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

-- better window navigation
vim.keymap.set("n", "<leader>wh", "<C-w>h", opts_with_desc("Switch to left window"))
vim.keymap.set("n", "<leader>wj", "<C-w>j", opts_with_desc("Switch to down window"))
vim.keymap.set("n", "<leader>wk", "<C-w>k", opts_with_desc("Switch to top window"))
vim.keymap.set("n", "<leader>wl", "<C-w>l", opts_with_desc("Switch to right window"))

vim.keymap.set("n", "<C-h>", "<C-w>h", opts_with_desc("Switch to left window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", opts_with_desc("Switch to down window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", opts_with_desc("Switch to top window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", opts_with_desc("Switch to right window"))

-- Remove the ZQ keybind just in case
vim.keymap.set("n", "ZQ", " ")

-- Tabs
vim.keymap.set("n", "<leader>T", vim.cmd.tabnew, { silent = true, desc = "Open a new tab" })

-- Terminal mode
function _G.set_terminal_keymaps()
  opts = term_opts
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- an autocommand for setting the above terminal-mode keymaps
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- allows us to move selected blocks of text, with proper indenting
-- from Mr. The Primeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- make sure you use a capital 'J' for this first one, or it won't work
vim.keymap.set("n", "J", "mzJ`z", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts) -- keep cursor in middle of screen when i move down
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts) -- keep cursor in middle of screen when i move up
vim.keymap.set("n", "n", "nzzzv", opts)       --
vim.keymap.set("n", "N", "nzzzv", opts)       --

-- Lazy
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { silent = true, desc = "Open Lazy plugin manager" })

-- Buffers
vim.keymap.set("n", "<leader>[", vim.cmd.bprev, { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>]", vim.cmd.bnext, { desc = "Next buffer" })
