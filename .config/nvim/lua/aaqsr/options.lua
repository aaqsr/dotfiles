local options = {
  clipboard = 'unnamedplus', -- always use clipboard for all operations
  conceallevel = 0,          -- show text normally
  fileencoding = 'utf-8',    -- file encoding for current buffer

  hlsearch = false,          -- don't highlight matches
  incsearch = true,          -- show the pattern matches as i type

  mouse = 'a',               -- enable mouse for 'all previous modes'
  pumheight = 5,             -- set the popup menu height to 10
  termguicolors = true,      -- enables 24-bit color in tui

  splitbelow = true,         -- open new horizontal splits below current buffer
  splitright = true,         -- open new vertical splits to the right of current buffer

  swapfile = false, -- don't create a swapfile
  backup = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
  -- timeoutlen = 1000, -- length of timeout for commands like 'jk' for exit

  number = true,         -- set line numbers, this setting shows the line number you're currently on
  relativenumber = true, -- make the line numbers relatives..."what are you doing, stepnumber?"

  numberwidth = 2,       -- the width of the number column
  signcolumn = 'yes',    -- show signs in signcolumn
  laststatus = 3, -- global statusline, thanks Neovim team :-)

  tabstop = 2,
  cindent = true, -- for C files
  softtabstop = 2,
  smarttab = true,
  shiftwidth = 2,
  expandtab = true,  -- changing things so they make sense to me
  shiftround = true, -- found out about this from VimTricks https://vim.town/@vimtricks

  ignorecase = true,
  smartcase = true,

  wrap = true,
  linebreak = true,

  guifont = "Nerd Font Medium:h14",
  -- shellxquote = "",    
  autoindent = true,   -- this should absolutely always be on
  smartindent = true,  -- so should this.

  scrolloff = 15,       -- like sidescrolloff but for the bottom side

  updatetime = 50,

  equalalways = false, -- all windows are made the same size after opening or closing

  showmode = false,  -- statusline shows the mode so we don't need to see it
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
