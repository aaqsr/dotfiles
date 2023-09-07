--------------------------
-- TOGGLETERM
--------------------------

-- as seen in "init.lua," here is the Vim way:
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- ...and the way you do it in Lua:



-- TODO! SET THIS UP PROPERLY
-- IT DOESN'T CLOSE
-- https://github.com/akinsho/toggleterm.nvim

return {
  'akinsho/toggleterm.nvim',
  lazy = false,
  config = function()
    require('toggleterm').setup {
      size = function (term)
          if term.direction == 'horizontal' then
        return 20
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      start_in_insert = true,
      autochdir = true,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
      direction = 'horizontal',
    }
    
    local Terminal = require("toggleterm.terminal").Terminal
    local python = Terminal:new({ cmd = 'python3', direction = 'horizontal', hidden = true })
    local calc = Terminal:new({ cmd = 'bc', direction = 'float', hidden = true })
    local racket = Terminal:new({ cmd = 'racket', direction = 'float', hidden = true })
  
    -- open a python repl
    function _PYTHON_TOGGLE()
    	python:toggle()
    end
    
    -- open bc so i can do difficult mathematical equationals
    function _CALC_TOGGLE()
      calc:toggle()
    end

    function _RACKET_TOGGLE()
      racket:toggle()
    end

    -- Keybinds
    local wk = require("which-key")

    wk.register({
      ["<leader>t"] = { name = "+Terminal" }
    })

    local opts =
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", 
      { silent = true, desc = "Open a floating terminal" })
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=12 direction=horizontal<cr>", 
      { silent = true, desc = "Open a horizontal terminal" }) -- 
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=vim.o.columns * 0.4 direction=vertical<cr>", 
      { silent = true, desc = "Open a vertical terminal"})
    vim.keymap.set("n", "<leader>tc", "<cmd>lua _CALC_TOGGLE()<cr>", 
      { silent = true, desc = "Open calculator"}) 
    vim.keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", 
      { silent = true, desc = "Open a Python repl"}) 
    vim.keymap.set("n", "<leader>tr", "<cmd>lua _RACKET_TOGGLE()<cr>", 
      { silent = true, desc = "Open a Racket repl"})

  end,
}

